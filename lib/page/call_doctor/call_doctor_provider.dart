import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/customer_order_model.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class CallDoctorProvider extends BaseProvider with ChangeNotifier {
  RTCVideoView videoView;
  RTCVideoView videoViewSelf;
  P2PSession callSession;
  P2PClient callClient;
  RTCVideoRenderer streamRender;
  RTCVideoRenderer streamRenderSelf;
  String dataRef;
  bool isMuteAudio = false;
  bool isVideoEnable = true;

  UserData _userData;

  CallDoctorProvider(this._userData);

  Future<void> signInConnectyCube(BuildContext context, AppointmentModel appointmentModel) async {
    final snapshot = await appointmentModel.doctorReference.get();
    final doctorConnectyCubeId = snapshot.data()["referenceConnectyCubeID"] as int;

    CubeUser cubeUser = CubeUser(
        id: _userData.userProfileModel.referenceConnectyCubeID,
        login: _userData.userProfileModel.userUID,
        email: _userData.userProfileModel.email,
        fullName: "${_userData.userProfileModel.firstName} ${_userData.userProfileModel.lastName}",
        password: _userData.userProfileModel.email);
    _connectCubeChat(context, cubeUser, doctorConnectyCubeId, appointmentModel.id);
  }

  void _connectCubeChat(BuildContext context, CubeUser cubeUser, int doctorConnectyCubeId, String appointmentId) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _initCustomerCallClient(context, doctorConnectyCubeId, appointmentId);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _initCustomerCallClient(context, doctorConnectyCubeId, appointmentId);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _initCustomerCallClient(BuildContext context, int doctorConnectyCubeId, String appointmentId) {
    callClient = P2PClient.instance;
    callClient.init();

    callClient.onReceiveNewSession = (incomingCallSession) {};
    callClient.onSessionClosed = (closedCallSession) {};

    Set<int> opponentsIds = {doctorConnectyCubeId};
    callSession = callClient.createCallSession(CallType.VIDEO_CALL, opponentsIds);
    _initCallSession(context, callSession, doctorConnectyCubeId, appointmentId);
  }

  void _initCallSession(BuildContext context, P2PSession callSession, int doctorConnectyCubeId, String appointmentId) {
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

    // sendPushNotification(doctorConnectyCubeId, appointmentId);
    callSession.startCall({"appointmentId": appointmentId});
  }

  Future<void> _handleRejectHangUpNoAnswer(BuildContext context) async {
    if (streamRenderSelf != null) {
      await streamRenderSelf.dispose();
    }
    if (streamRender != null) {
      await streamRender.dispose();
    }
    if (callClient != null) {
      callClient.destroy();
      callClient.init();
    }
    videoViewSelf = null;
    videoView = null;
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> endCall() async {
    if (streamRenderSelf != null) {
      await streamRenderSelf.dispose();
    }
    if (streamRender != null) {
      await streamRender.dispose();
    }
    if (callSession != null) {
      callSession.hungUp();
    }
    if (callClient != null) {
      callClient.destroy();
    }
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

  void sendPushNotification(int doctorConnectyCubeId, String appointmentId) {
    bool isProduction = bool.fromEnvironment('dart.vm.product');

    CreateEventParams params = CreateEventParams();
    params.parameters = {
      'message': "มีการโทรเข้าจาก " + "${_userData.userProfileModel.firstName} ${_userData.userProfileModel.lastName}",
      // 'message' field is required
      'custom_parameter1': appointmentId,
      'ios_voip': 1
      // to send VoIP push notification to iOS
      //more standard parameters you can found by link https://developers.connectycube.com/server/push_notifications?id=universal-push-notifications
    };

    params.notificationType = NotificationType.PUSH;
    params.environment = isProduction ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;
    params.usersIds = [doctorConnectyCubeId, _userData.userProfileModel.referenceConnectyCubeID];

    createEvent(params.getEventForRequest()).then((cubeEvent) {}).catchError((error) {
    });
  }
}
