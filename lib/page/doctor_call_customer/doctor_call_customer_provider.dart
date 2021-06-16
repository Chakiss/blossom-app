import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/fcm/fcm_manager.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class DoctorCallCustomerProvider extends BaseProvider with ChangeNotifier {
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

  DoctorCallCustomerProvider(this._userData);

  String _appointmentId;
  int _userConnectyCubeId;
  bool _isGoToDiagnose = false;

  Future<void> signInConnectyCube(BuildContext context, AppointmentModel appointmentModel) async {
    final snapshot = await appointmentModel.userReference.get();
    final UserProfileModel userProfileModel = UserProfileModel.fromJson(snapshot.id, snapshot.data());
    _appointmentId = appointmentModel.id;
    _userConnectyCubeId = userProfileModel.referenceConnectyCubeID;
    CubeUser cubeUser = CubeUser(
        id: _userData.doctorInfoModel.referenceConnectyCubeID,
        login: _userData.doctorInfoModel.doctorId,
        email: _userData.doctorInfoModel.email,
        fullName: "${_userData.doctorInfoModel.firstName} ${_userData.doctorInfoModel.lastName}",
        password: _userData.doctorInfoModel.email);
    _connectCubeChat(context, cubeUser, userProfileModel, appointmentModel.id);
  }

  void _connectCubeChat(
      BuildContext context, CubeUser cubeUser, UserProfileModel userProfileModel, String appointmentId) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _initCustomerCallClient(context, userProfileModel, appointmentId);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _initCustomerCallClient(context, userProfileModel, appointmentId);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _initCustomerCallClient(BuildContext context, UserProfileModel userProfileModel, String appointmentId) {
    callClient = P2PClient.instance;
    Set<int> opponentsIds = {userProfileModel.referenceConnectyCubeID};
    callSession = callClient.createCallSession(CallType.VIDEO_CALL, opponentsIds);
    _initCallSession(context, callSession, userProfileModel, appointmentId);
  }

  void _initCallSession(
      BuildContext context, P2PSession callSession, UserProfileModel userProfileModel, String appointmentId) {
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
      _isGoToDiagnose = true;
    };

    callSession.onRemoteStreamRemoved = (callSession, opponentId, mediaStream) {
      // called when remote media was removed
      logger.d("Prew, onRemoteStreamRemoved");
    };

    callSession.onUserNoAnswer = (callSession, opponentId) async {
      // called when did not receive an answer from opponent during timeout (default timeout is 60 seconds)
      logger.d("Prew, onUserNoAnswer");
      callClient.removeSession(callSession);
      await _handleRejectNoAnswer(context);
    };

    callSession.onCallRejectedByUser = (callSession, opponentId, [userInfo]) async {
      // called when received 'reject' signal from opponent
      logger.d("Prew, onCallRejectedByUser");
      callClient.removeSession(callSession);
      await _handleRejectNoAnswer(context);
    };

    callSession.onCallAcceptedByUser = (callSession, opponentId, [userInfo]) {
      // called when received 'accept' signal from opponent
      logger.d("Prew, onCallAcceptedByUser");
    };

    callSession.onReceiveHungUpFromUser = (callSession, opponentId, [userInfo]) async {
      // called when received 'hungUp' signal from opponent
      logger.d("Prew, onReceiveHungUpFromUser");
      callClient.removeSession(callSession);
      await _handleHungUp(context);
    };

    callSession.onSessionClosed = (callSession) {
      // called when current session was closed
      logger.d("Prew, onSessionClosed");
      callClient.removeSession(callSession);
    };

    // sendPushNotification(doctorConnectyCubeId, appointmentId);
    FCMManager.sendPushNotificationFromCall(
        "${_userData.doctorInfoModel?.firstName ?? ""} ${_userData.doctorInfoModel?.lastName ?? ""} : กำลังโทรหาคุณ",
        _userData.doctorInfoModel.referenceConnectyCubeID,
        userProfileModel.referenceConnectyCubeID,
        "${_userData.doctorInfoModel?.firstName ?? ""} ${_userData.doctorInfoModel?.lastName ?? ""}");
    callSession.startCall({"appointmentId": appointmentId});
  }

  Future<void> _handleRejectNoAnswer(BuildContext context) async {
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
  }

  Future<void> _handleHungUp(BuildContext context) async {
    if (streamRenderSelf != null) {
      await streamRenderSelf.dispose();
    }
    if (streamRender != null) {
      await streamRender.dispose();
    }
    Navigator.pop(context);
    if (_isGoToDiagnose) {
      Navigator.push(context, RouteManager.routeDoctorDiagnose(_userConnectyCubeId, _appointmentId));
    }
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
    if (_isGoToDiagnose) {
      Navigator.push(context, RouteManager.routeDoctorDiagnose(_userConnectyCubeId, _appointmentId));
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
}
