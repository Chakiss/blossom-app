import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/fcm/fcm_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class ChatFromNotificationProvider extends BaseProvider with ChangeNotifier {
  String _dialogId;
  String _fullName;
  int _senderId;
  UserData _userData;

  ChatFromNotificationProvider(this._dialogId, this._fullName, this._senderId, this._userData);

  CubeDialog _cubeDialog;
  List<CubeDialog> _list;
  List<CubeMessage> chatList;

  Future<void> signInConnectyCube(BuildContext context) async {
    if (_userData.userProfileModel != null) {
      CubeUser cubeUser = CubeUser(
          id: _userData.userProfileModel.referenceConnectyCubeID,
          login: _userData.userProfileModel.userUID,
          email: _userData.userProfileModel.email,
          fullName: "${_userData.userProfileModel.firstName} ${_userData.userProfileModel.lastName}",
          password: _userData.userProfileModel.email);
      _connectCubeChat(context, cubeUser);
    } else {
      CubeUser cubeUser = CubeUser(
          id: _userData.doctorInfoModel.referenceConnectyCubeID,
          login: _userData.doctorInfoModel.doctorId,
          email: _userData.doctorInfoModel.email,
          fullName: "${_userData.doctorInfoModel.firstName} ${_userData.doctorInfoModel.lastName}",
          password: _userData.doctorInfoModel.email);
      _connectCubeChat(context, cubeUser);
    }
  }

  void _connectCubeChat(BuildContext context, CubeUser cubeUser) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _getDialogList(context);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _getDialogList(context);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _getDialogList(BuildContext context) {
    getDialogs().then((pagedResult) {
      print(pagedResult);
      _list = pagedResult.items;
      _getDialogFromUserIdAndDoctorId(context);
    }).catchError((error) {
      print(error);
    });
  }

  void _getDialogFromUserIdAndDoctorId(BuildContext context) {
    final filterList = _list
        .where((element) =>
            element.dialogId == this._dialogId )
        .toList();
    if (filterList?.isEmpty ?? true) {
      Navigator.pop(context);
    } else {
      _cubeDialog = filterList.first;
      _getChatHistory();
    }
  }

  void sendMessage(String text) {
    CubeMessage message = CubeMessage();
    message.body = text;
    message.dateSent = DateTime.now().millisecondsSinceEpoch;
    message.senderId = _userData.userProfileModel?.referenceConnectyCubeID ?? _userData.doctorInfoModel?.referenceConnectyCubeID;
    message.markable = true;
    message.saveToHistory = true;

    _cubeDialog.sendMessage(message).then((cubeMessage) {
      FCMManager.sendPushNotificationFromChat(
          _dialogId,
          "$_fullName : $text",
          _userData.userProfileModel?.referenceConnectyCubeID ?? _userData.doctorInfoModel?.referenceConnectyCubeID,
          _senderId,
          _fullName ?? "");
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
