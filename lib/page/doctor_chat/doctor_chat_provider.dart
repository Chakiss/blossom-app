import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/fcm/fcm_manager.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class DoctorChatProvider extends BaseProvider with ChangeNotifier {
  AppointmentModel _appointmentModel;
  UserData _userData;

  DoctorChatProvider(this._appointmentModel, this._userData);

  UserProfileModel userProfileModel;
  CubeDialog _cubeDialog;
  List<CubeDialog> _list;
  List<CubeMessage> chatList;

  Future<void> signInConnectyCube(BuildContext context) async {
    final snapshot = await _appointmentModel.userReference.get();
    userProfileModel = UserProfileModel.fromJson(snapshot.id, snapshot.data());
    notifyListeners();

    CubeUser cubeUser = CubeUser(
        id: _userData.doctorInfoModel.referenceConnectyCubeID,
        login: _userData.doctorInfoModel.doctorId,
        email: _userData.doctorInfoModel.email,
        fullName: "${_userData.doctorInfoModel.firstName} ${_userData.doctorInfoModel.lastName}",
        password: _userData.doctorInfoModel.email);
    _connectCubeChat(context, cubeUser);
  }

  void _connectCubeChat(BuildContext context, CubeUser cubeUser) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      // _createOneByOneChat();
      _getDialogList();
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        // _createOneByOneChat();
        _getDialogList();
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _createOneByOneChatDialog() {
    CubeDialog newDialog = CubeDialog(CubeDialogType.PRIVATE,
        occupantsIds: [_userData.doctorInfoModel.referenceConnectyCubeID, userProfileModel.referenceConnectyCubeID]);
    createDialog(newDialog).then((createdDialog) {
      _cubeDialog = createdDialog;
    }).catchError((error) {
      print(error);
    });
  }

  void _getDialogList() {
    getDialogs().then((pagedResult) {
      print(pagedResult);
      _list = pagedResult.items;
      _getDialogFromUserIdAndDoctorId();
    }).catchError((error) {
      print(error);
    });
  }

  void _getDialogFromUserIdAndDoctorId() {
    final filterList = _list
        .where((element) =>
            element.occupantsIds.contains(_userData.doctorInfoModel.referenceConnectyCubeID) &&
            element.occupantsIds.contains(userProfileModel.referenceConnectyCubeID) &&
            element.occupantsCount == 2)
        .toList();
    if (filterList?.isEmpty ?? true) {
      _createOneByOneChatDialog();
    } else {
      _cubeDialog = filterList.first;
      _getChatHistory();
    }
  }

  void sendMessage(String text) {
    CubeMessage message = CubeMessage();
    message.body = text;
    message.dateSent = DateTime.now().millisecondsSinceEpoch;
    message.senderId = _userData.doctorInfoModel.referenceConnectyCubeID;
    message.markable = true;
    message.saveToHistory = true;

    _cubeDialog.sendMessage(message).then((cubeMessage) {
      FCMManager.sendPushNotificationFromChat(
          _cubeDialog.dialogId,
          "${_userData.doctorInfoModel?.firstName ?? ""} : $text",
          _userData.doctorInfoModel.referenceConnectyCubeID,
          userProfileModel.referenceConnectyCubeID,
          "${_userData.doctorInfoModel?.firstName ?? ""} ${_userData.doctorInfoModel?.lastName ?? ""}");
      chatList.insert(0, cubeMessage);
      notifyListeners();
    }).catchError((error) {});
  }

  void _getChatHistory() {
    GetMessagesParameters params = GetMessagesParameters();
    params.limit = 100;
    params.markAsRead = true;
    params.sorter = RequestSorter(OrderType.DESC, "", "date_sent");

    getMessages(_cubeDialog.dialogId, params.getRequestParameters()).then((pagedResult) {
      print(pagedResult);
      chatList = pagedResult.items;
      notifyListeners();
      _observeMessage();
    }).catchError((error) {
      print(error);
      chatList = [];
      _observeMessage();
    });
  }

  void _observeMessage() {
    ChatMessagesManager chatMessagesManager = CubeChatConnection.instance.chatMessagesManager;
    chatMessagesManager.chatMessagesStream.listen((newMessage) {
      chatList.insert(0, newMessage);
      notifyListeners();
    }).onError((error) {
      // error received
    });
  }
}
