import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_page.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';

class DoctorMainProvider extends BaseProvider with ChangeNotifier {
  Widget page = DoctorHomePage();
  P2PClient callClient;

  void setPage(Widget page) {
    this.page = page;
    notifyListeners();
  }

  void connectConnectyCube(BuildContext context) {
    _signInConnectyCube(context);
  }

  void _signInConnectyCube(BuildContext context) {
    CubeUser cubeUser =
        CubeUser(id: 4132679, login: "prewaraiiwa", email: "prewaraiiwa@gmail.com", password: "12345678");
    _connectCubeChat(context, cubeUser);
  }

  void _connectCubeChat(BuildContext context, CubeUser cubeUser) {
    if (CubeChatConnection.instance.isAuthenticated()) {
      _initCallClient(context);
    } else {
      CubeChatConnection.instance.login(cubeUser).then((value) {
        _initCallClient(context);
      }).catchError((error) {
        print(error);
      });
    }
  }

  void _initCallClient(BuildContext context) {
    callClient = P2PClient.instance;
    callClient.init();

    callClient.onReceiveNewSession = (incomingCallSession) {
      _goToIncomingCallPage(context, incomingCallSession);
    };
    callClient.onSessionClosed = (closedCallSession) {

    };
  }

  void _goToIncomingCallPage(BuildContext context, P2PSession incomingCallSession) {
    Navigator.push(context, RouteManager.routeDoctorIncomingCall(incomingCallSession));
  }
}
