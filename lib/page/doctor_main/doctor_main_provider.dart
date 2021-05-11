import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/page/doctor_history/doctor_history_page.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_page.dart';
import 'package:blossom_clinic/page/doctor_profile/doctor_profile_page.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';

class DoctorMainProvider extends BaseProvider with ChangeNotifier {
  Widget page;
  P2PClient callClient;

  UserData _userData;
  int initIndex;

  DoctorMainProvider(this._userData, {this.initIndex = 0}) {
    switch (initIndex) {
      case 0:
        page = DoctorHomePage();
        break;
      case 1:
        page = DoctorHistoryPage();
        break;
      case 2:
        page = DoctorProfilePage();
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
      
    } catch (e) {
      _signInConnectyCube(context);
    }
  }

  void _signInConnectyCube(BuildContext context) {
    CubeUser cubeUser = CubeUser(
        id: _userData.doctorInfoModel.referenceConnectyCubeID,
        login: _userData.doctorInfoModel.doctorId,
        email: _userData.doctorInfoModel.email,
        password: _userData.doctorInfoModel.email);
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
    Navigator.push(context, RouteManager.routeDoctorIncomingCall(incomingCallSession));
  }
}
