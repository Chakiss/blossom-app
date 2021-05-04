import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class CallCustomerProvider extends BaseProvider with ChangeNotifier {
  RTCVideoView videoView;
  RTCVideoView videoViewSelf;
  P2PSession callSession;
  RTCVideoRenderer streamRender;
  RTCVideoRenderer streamRenderSelf;
  int userConnectyCudeId;
  String _appointmentId;
  bool isMuteAudio = false;
  bool isVideoEnable = true;

  void initCallSession(BuildContext context, P2PSession callSession) {
    this.callSession = callSession;

    callSession.onLocalStreamReceived = (mediaStream) async {
      logger.d("Prew, onLocalStreamReceived");
      streamRenderSelf = RTCVideoRenderer();
      await streamRenderSelf.initialize();
      streamRenderSelf.srcObject = mediaStream;

      // create view to put it somewhere on screen
      videoViewSelf = RTCVideoView(
        streamRenderSelf,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        mirror: true,
      );
      notifyListeners();
    };

    callSession.onRemoteStreamReceived = (callSession, opponentId, mediaStream) async {
      // create video renderer and set media stream to it
      logger.d("Prew, onRemoteStreamReceived");
      callSession.enableSpeakerphone(true);
      streamRender = RTCVideoRenderer();
      await streamRender.initialize();
      streamRender.srcObject = mediaStream;

      // create view to put it somewhere on screen
      videoView = RTCVideoView(
        streamRender,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        mirror: true,
      );
      notifyListeners();
    };

    callSession.onRemoteStreamRemoved = (callSession, opponentId, mediaStream) {
      // called when remote media was removed
      logger.d("Prew, onRemoteStreamRemoved");
    };

    callSession.onUserNoAnswer = (callSession, opponentId) async {
      // called when did not receive an answer from opponent during timeout (default timeout is 60 seconds)
      logger.d("Prew, onUserNoAnswer");
      await _handleRejectHangUpNoAnswer(context);
    };

    callSession.onCallRejectedByUser = (callSession, opponentId, [userInfo]) async {
      // called when received 'reject' signal from opponent
      logger.d("Prew, onCallRejectedByUser");
      await _handleRejectHangUpNoAnswer(context);
    };

    callSession.onCallAcceptedByUser = (callSession, opponentId, [userInfo]) {
      // called when received 'accept' signal from opponent
      logger.d("Prew, onCallAcceptedByUser");
    };

    callSession.onReceiveHungUpFromUser = (callSession, opponentId, [userInfo]) async {
      // called when received 'hungUp' signal from opponent
      logger.d("Prew, onReceiveHungUpFromUser");
      await _handleRejectHangUpNoAnswer(context);
    };

    callSession.onSessionClosed = (callSession) {
      // called when current session was closed
      logger.d("Prew, onSessionClosed");
    };

    _appointmentId = callSession.cubeSdp.userInfo["appointmentId"];
    userConnectyCudeId = callSession.callerId;
    callSession.acceptCall();
  }

  Future<void> _handleRejectHangUpNoAnswer(BuildContext context) async {
    if (streamRenderSelf != null) {
      await streamRenderSelf.dispose();
    }
    if (streamRender != null) {
      await streamRender.dispose();
    }
    videoViewSelf = null;
    videoView = null;
    notifyListeners();
    Navigator.pop(context);
    _goToDoctorDiagnosePage(context);
  }

  Future<void> endCall(BuildContext context) async {
    if (streamRenderSelf != null) {
      await streamRenderSelf.dispose();
    }
    if (streamRender != null) {
      await streamRender.dispose();
    }
    if (callSession != null) {
      callSession.hungUp();
    }
    Navigator.pop(context);
    _goToDoctorDiagnosePage(context);
  }

  void setMuteAudio() {
    if (callSession != null) {
      if (isMuteAudio) {
        isMuteAudio = false;
      } else {
        isMuteAudio = true;
      }
      callSession.setMicrophoneMute(isMuteAudio);
      notifyListeners();
    }
  }

  void setVideoEnableDisable() {
    if (callSession != null) {
      if (isVideoEnable) {
        isVideoEnable = false;
      } else {
        isVideoEnable = true;
      }
      callSession.setVideoEnabled(isVideoEnable);
      notifyListeners();
    }
  }

  void _goToDoctorDiagnosePage(BuildContext context) {
    if (_appointmentId?.isNotEmpty ?? false) {
      print("appointmentId: $_appointmentId");
      Navigator.push(context, RouteManager.routeDoctorDiagnose(userConnectyCudeId, _appointmentId));
    }
  }
}
