import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class VoiceCallCustomerProvider extends BaseProvider with ChangeNotifier {
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

  UserData _userData;
  AppointmentModel _appointmentModel;

  VoiceCallCustomerProvider(this._userData, this._appointmentModel);

  String customerFullName;
  String minute;
  String second;
  StopWatchTimer _stopWatchTimer;


  Future<void> signInConnectyCube(BuildContext context) async {
    final snapshot = await _appointmentModel.userReference.get();
    final UserProfileModel userProfileModel = UserProfileModel.fromJson(snapshot.id, snapshot.data());
    customerFullName = "${userProfileModel.firstName} ${userProfileModel.lastName}";
    notifyListeners();

    CubeUser cubeUser = CubeUser(
        id: _userData.doctorInfoModel.referenceConnectyCubeID,
        login: _userData.doctorInfoModel.doctorId,
        email: _userData.doctorInfoModel.email,
        fullName: "${_userData.doctorInfoModel.firstName} ${_userData.doctorInfoModel.lastName}",
        password: _userData.doctorInfoModel.email);
    _connectCubeChat(context, cubeUser, userProfileModel);
  }

  void _connectCubeChat(
      BuildContext context, CubeUser cubeUser, UserProfileModel userProfileModel) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _initCustomerCallClient(context, userProfileModel);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _initCustomerCallClient(context, userProfileModel);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _initCustomerCallClient(BuildContext context, UserProfileModel userProfileModel) {
    callClient = P2PClient.instance;
    Set<int> opponentsIds = {userProfileModel.referenceConnectyCubeID};
    callSession = callClient.createCallSession(CallType.AUDIO_CALL, opponentsIds);
    _initCallSession(context, callSession, userProfileModel);
  }

  void _initCallSession(
      BuildContext context, P2PSession callSession, UserProfileModel userProfileModel) {
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
    callSession.startCall({"appointmentId": _appointmentModel.id});
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

  void sendPushNotification(int doctorConnectyCubeId, String appointmentId) {
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
    params.environment = CubeEnvironment.PRODUCTION;
    params.usersIds = [doctorConnectyCubeId, _userData.userProfileModel.referenceConnectyCubeID];

    createEvent(params.getEventForRequest()).then((cubeEvent) {}).catchError((error) {});
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }
}
