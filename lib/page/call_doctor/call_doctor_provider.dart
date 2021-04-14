import 'package:blossom_clinic/model/request/end_video_conference_request_model.dart';
import 'package:blossom_clinic/model/request/start_video_conference_request_model.dart';
import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/response/get_book_history_response_model.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class CallDoctorProvider extends BaseProvider with ChangeNotifier {

  RemoteRepository _remoteRepository;
  UserModel _userModel;
  GetBookingHistoryResponseModel _historyResponseModel;
  RTCVideoView videoView;
  RTCVideoView videoViewSelf;
  P2PSession callSession;
  P2PClient callClient;
  RTCVideoRenderer streamRender;
  RTCVideoRenderer streamRenderSelf;
  String dataRef;
  bool isMuteAudio = false;
  bool isVideoEnable = true;

  CallDoctorProvider(this._remoteRepository, this._userModel, this._historyResponseModel);

  void signInConnectyCube(BuildContext context) {
    CubeUser cubeUser = CubeUser(
        id: int.parse(_userModel.profileResponseModel.cubeId ?? "0"),
        login: _userModel.profileResponseModel.email,
        email: _userModel.profileResponseModel.email,
        fullName: "${_userModel.signInResponseModel?.firstName ?? ""} ${_userModel.signInResponseModel?.lastName ?? ""} ",
        password: _userModel.profileResponseModel.cubeSecreteKey);

    _connectCubeChat(context, cubeUser);
  }

  void _connectCubeChat(BuildContext context, CubeUser cubeUser) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _initCustomerCallClient(context);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _initCustomerCallClient(context);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _initCustomerCallClient(BuildContext context) {
    callClient = P2PClient.instance;
    callClient.init();

    callClient.onReceiveNewSession = (incomingCallSession) {};
    callClient.onSessionClosed = (closedCallSession) {};

    Set<int> opponentsIds = {int.parse(_historyResponseModel.cubeId)};
    callSession = callClient.createCallSession(CallType.VIDEO_CALL, opponentsIds);
    _initCallSession(context, callSession);
  }

  void _initCallSession(BuildContext context, P2PSession callSession) {
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

    callSession.onUserNoAnswer = (callSession, opponentId) {
      // called when did not receive an answer from opponent during timeout (default timeout is 60 seconds)
      logger.d("Prew, onUserNoAnswer");
    };

    callSession.onCallRejectedByUser = (callSession, opponentId, [userInfo]) {
      // called when received 'reject' signal from opponent
      logger.d("Prew, onCallRejectedByUser");
    };

    callSession.onCallAcceptedByUser = (callSession, opponentId, [userInfo]) {
      // called when received 'accept' signal from opponent
      logger.d("Prew, onCallAcceptedByUser");
    };

    callSession.onReceiveHungUpFromUser = (callSession, opponentId, [userInfo]) async {
      // called when received 'hungUp' signal from opponent
      logger.d("Prew, onReceiveHungUpFromUser");
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
    };

    callSession.onSessionClosed = (callSession) {
      // called when current session was closed
      logger.d("Prew, onSessionClosed");
      if (dataRef != null) {
        callServiceStampEndVideoCall(callSession);
      }
    };

    callServiceStampStartVideoCall(callSession);
  }

  Future<void> callServiceStampStartVideoCall(P2PSession callSession) async {
    StartVideoConferenceRequestModel requestModel = StartVideoConferenceRequestModel(
        _userModel.profileResponseModel.cubeId, callSession.opponentsIds.first.toString());
    var result = await _remoteRepository.startVideoCall(_userModel.getBearerToken(), requestModel);
    result.whenWithResult((data) {
      dataRef = data.data;
      callSession.startCall();
    }, (status) {});
  }

  Future<void> callServiceStampEndVideoCall(P2PSession callSession) async {
    EndVideoConferenceRequestModel requestModel = EndVideoConferenceRequestModel(
        _userModel.profileResponseModel.cubeId, callSession.opponentsIds.first.toString(), dataRef);
    var result = await _remoteRepository.endVideoCall(_userModel.getBearerToken(), requestModel);
    result.whenWithResult((data) {}, (status) {});
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
    }
  }
}
