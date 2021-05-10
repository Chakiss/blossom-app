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
    _signInConnectyCube(context);
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
}
