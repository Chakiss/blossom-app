import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/fcm/fcm_manager.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class VoiceCallDoctorProvider extends BaseProvider with ChangeNotifier {
  RTCVideoView videoView;
  RTCVideoView videoViewSelf;
  P2PSession callSession;
  P2PClient callClient;
  RTCVideoRenderer streamRender;
  RTCVideoRenderer streamRenderSelf;
  String dataRef;
  bool isMuteAudio = false;
  bool isSpeakerEnable = true;
  bool isCanSetSpeaker = false;
  DoctorInfoModel doctorInfoModel;

  AppointmentModel _appointmentModel;
  UserData _userData;
  String doctorFullName;
  String doctorDisplayPhoto;

  String minute;
  String second;
  StopWatchTimer _stopWatchTimer;

  VoiceCallDoctorProvider(this._userData, this._appointmentModel);

  Future<void> signInConnectyCube(BuildContext context) async {
    final snapshot = await _appointmentModel.doctorReference.get();
    final DoctorInfoModel doctorInfoModel = DoctorInfoModel.fromJson(snapshot.id, snapshot.data());
    doctorDisplayPhoto = doctorInfoModel?.displayPhoto;
    doctorFullName = "${doctorInfoModel.firstName} ${doctorInfoModel.lastName}";
    notifyListeners();

    CubeUser cubeUser = CubeUser(
        id: _userData.userProfileModel.referenceConnectyCubeID,
        login: _userData.userProfileModel.userUID,
        email: _userData.userProfileModel.email,
        fullName: "${_userData.userProfileModel.firstName} ${_userData.userProfileModel.lastName}",
        password: _userData.userProfileModel.email);
    _connectCubeChat(context, cubeUser, doctorInfoModel, _appointmentModel.id);
  }

  void _connectCubeChat(
      BuildContext context, CubeUser cubeUser, DoctorInfoModel doctorInfoModel, String appointmentId) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _initCustomerCallClient(context, doctorInfoModel, appointmentId);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _initCustomerCallClient(context, doctorInfoModel, appointmentId);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _initCustomerCallClient(BuildContext context, DoctorInfoModel doctorInfoModel, String appointmentId) {
    callClient = P2PClient.instance;
    callClient.init();

    callClient.onReceiveNewSession = (incomingCallSession) {};
    callClient.onSessionClosed = (closedCallSession) {};

    Set<int> opponentsIds = {doctorInfoModel.referenceConnectyCubeID};
    callSession = callClient.createCallSession(CallType.AUDIO_CALL, opponentsIds);
    _initCallSession(context, callSession, doctorInfoModel, appointmentId);
  }

  void _initCallSession(
      BuildContext context, P2PSession callSession, DoctorInfoModel doctorInfoModel, String appointmentId) {
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
      this.doctorInfoModel = doctorInfoModel;
      callSession.enableSpeakerphone(true);
      isCanSetSpeaker = true;
      streamRender = RTCVideoRenderer();
      await streamRender.initialize();
      streamRender.srcObject = mediaStream;

      // create view to put it somewhere on screen
      videoView = RTCVideoView(
        streamRender,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        mirror: true,
      );

      _stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countUp,
        onChange: (value) {

        },
        onChangeRawSecond: (value) {
          print("RawSecond");
          print(value);
          second = "${value % 60}";
          notifyListeners();
        },
        onChangeRawMinute: (value) {
          print("RawMinute");
          print(value);
          minute = "$value";
        },
      );
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    };

    callSession.onRemoteStreamRemoved = (callSession, opponentId, mediaStream) {
      // called when remote media was removed
      logger.d("Prew, onRemoteStreamRemoved");
    };

    callSession.onUserNoAnswer = (callSession, opponentId) async {
      // called when did not receive an answer from opponent during timeout (default timeout is 60 seconds)
      logger.d("Prew, onUserNoAnswer");
      await _handleRejectNoAnswer(context);
    };

    callSession.onCallRejectedByUser = (callSession, opponentId, [userInfo]) async {
      // called when received 'reject' signal from opponent
      logger.d("Prew, onCallRejectedByUser");
      await _handleRejectNoAnswer(context);
    };

    callSession.onCallAcceptedByUser = (callSession, opponentId, [userInfo]) {
      // called when received 'accept' signal from opponent
      logger.d("Prew, onCallAcceptedByUser");
    };

    callSession.onReceiveHungUpFromUser = (callSession, opponentId, [userInfo]) async {
      // called when received 'hungUp' signal from opponent
      logger.d("Prew, onReceiveHungUpFromUser");
      await _handleHungUp(context, doctorInfoModel);
    };

    callSession.onSessionClosed = (callSession) {
      // called when current session was closed
      logger.d("Prew, onSessionClosed");
    };

    // sendPushNotification(doctorConnectyCubeId, appointmentId);
    FCMManager.sendPushNotificationFromCall(
        "${_userData.userProfileModel?.firstName ?? ""} ${_userData.userProfileModel?.lastName ?? ""} : กำลังโทรหาคุณ",
        _userData.userProfileModel.referenceConnectyCubeID,
        doctorInfoModel.referenceConnectyCubeID,
        "${_userData.userProfileModel?.firstName ?? ""} ${_userData.userProfileModel?.lastName ?? ""}");
    callSession.startCall({"appointmentId": appointmentId});
  }

  Future<void> _handleRejectNoAnswer(BuildContext context) async {
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
    _stopWatchTimer?.onExecute?.add(StopWatchExecute.stop);
    notifyListeners();
    Navigator.pop(context);
  }

  Future<void> _handleHungUp(BuildContext context, DoctorInfoModel doctorInfoModel) async {
    if (streamRenderSelf != null) {
      await streamRenderSelf.dispose();
    }
    if (streamRender != null) {
      await streamRender.dispose();
    }
    if (callClient != null) {
      callClient.destroy();
    }
    _stopWatchTimer?.onExecute?.add(StopWatchExecute.stop);
    Navigator.pushReplacement(context, RouteManager.routeCustomerReviewDoctor(doctorInfoModel, _appointmentModel));
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
    if (callClient != null) {
      callClient.destroy();
    }
    _stopWatchTimer?.onExecute?.add(StopWatchExecute.stop);
    if (doctorInfoModel != null) {
      Navigator.pushReplacement(context, RouteManager.routeCustomerReviewDoctor(doctorInfoModel, _appointmentModel));
    } else {
      Navigator.pop(context);
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

  void setSpeakerEnableDisable() {
    if (callSession != null) {
      if (isCanSetSpeaker) {
        if (isSpeakerEnable) {
          isSpeakerEnable = false;
        } else {
          isSpeakerEnable = true;
        }
        callSession.enableSpeakerphone(isSpeakerEnable);
        notifyListeners();
      }
    }
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }
}
