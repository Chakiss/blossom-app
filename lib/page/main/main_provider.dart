import 'dart:convert';

import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/doctor/doctor_page.dart';
import 'package:blossom_clinic/page/drug/drug_page.dart';
import 'package:blossom_clinic/page/history/history_page.dart';
import 'package:blossom_clinic/page/profile/profile_page.dart';
import 'package:blossom_clinic/page/service/service_page.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class MainProvider extends BaseProvider with ChangeNotifier {
  Widget page;
  P2PClient callClient;

  UserData _userData;
  int initIndex;

  MainProvider(this._userData, {this.initIndex = 0}) {
    switch (initIndex) {
      case 0:
        page = DoctorPage();
        break;
      case 1:
        page = HistoryPage();
        break;
      case 2:
        page = ServicePage();
        break;
      case 3:
        page = DrugPage();
        break;
      case 4:
        page = ProfilePage();
        break;
    }
  }

  void setPage(Widget page) {
    this.page = page;
    notifyListeners();
  }

  void connectConnectyCube(BuildContext context) {
    try {
      CubeChatConnection.instance.logout();
      _signInConnectyCube(context);
    } catch (e) {
      _signInConnectyCube(context);
    }
  }

  void _signInConnectyCube(BuildContext context) {
    CubeUser cubeUser = CubeUser(
        id: _userData.userProfileModel.referenceConnectyCubeID,
        login: _userData.userProfileModel.userUID,
        email: _userData.userProfileModel.email,
        fullName: "${_userData.userProfileModel.firstName} ${_userData.userProfileModel.lastName}",
        password: _userData.userProfileModel.email);
    _connectCubeChat(context, cubeUser);
  }

  void _connectCubeChat(BuildContext context, CubeUser cubeUser) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _signIn(context, cubeUser);
      _initCallClient(context);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _signIn(context, cubeUser);
        _initCallClient(context);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _signIn(BuildContext context, CubeUser cubeUser) {
    signIn(cubeUser).then((cubeUser) {
      print(cubeUser);
      subscribeNotification();
      _initFlutterNotification(context);
    }).catchError((error) {
      print(error);
    });
  }

  void _initCallClient(BuildContext context) {
    callClient = P2PClient.instance;
    callClient.init();

    callClient.onReceiveNewSession = (incomingCallSession) {
      _goToIncomingCallPage(
        context,
        incomingCallSession,
      );
    };
    callClient.onSessionClosed = (closedCallSession) {};
  }

  void _goToIncomingCallPage(BuildContext context, P2PSession incomingCallSession) {
    Navigator.push(context, RouteManager.routeCustomerIncomingCall(incomingCallSession));
  }

  void _initFlutterNotification(BuildContext context) {
    var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) {
      return;
    });
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (payload) {
      // when user tap on notification.
      Map<String, dynamic> json = Map<String, dynamic>.from(jsonDecode(payload));
      print(json);
      String type = json["notificationType"] as String;
      if (type != null) {
        switch (type) {
          case "chat":
            final String dialogId = json["dialogId"] as String;
            final String fullName = json["fullName"] as String;
            int senderId;
            if (json["senderId"] is String) {
              senderId = int.parse(json["senderId"] as String);
            } else if (json["senderId"] is int)
              senderId = json["senderId"] as int;
            Navigator.push(context, RouteManager.routeChatFromNotification(dialogId, fullName, senderId));
            break;
          case "voice":
            break;
          case "video":
            break;
        }
      }
      return;
    });
  }
}
