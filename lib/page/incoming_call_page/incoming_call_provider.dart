import 'package:blossom_clinic/base/base_provider.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class IncomingCallProvider extends BaseProvider with ChangeNotifier {
  String customerName;

  void handleHangUpCall(BuildContext context, P2PSession callSession) {
    callSession.onReceiveHungUpFromUser = (callSession, opponentId, [userInfo]) {
      Navigator.pop(context);
    };
  }

  void getUserDetail(P2PSession callSession) {
    getUserById(callSession.opponentsIds.first).then((cubeUser) {
      customerName = cubeUser.fullName ?? cubeUser.id.toString();
      notifyListeners();
    }).catchError((error) {});
  }
}
