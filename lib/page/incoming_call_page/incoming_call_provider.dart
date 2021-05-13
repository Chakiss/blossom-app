import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/usecase/get_user_profile_with_connecty_cube_id_use_case.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

class IncomingCallProvider extends BaseProvider with ChangeNotifier {
  String customerName;
  GetUserProfileWithConnectyCubeIdUseCase _getUserProfileWithConnectyCubeIdUseCase;

  IncomingCallProvider(this._getUserProfileWithConnectyCubeIdUseCase);
  UserProfileModel userProfileModel;

  void handleHangUpCall(BuildContext context, P2PSession callSession) {
    callSession.onReceiveHungUpFromUser = (callSession, opponentId, [userInfo]) {
      Navigator.pop(context);
    };
  }

  Future<void> getUserDetail(P2PSession callSession) async {
    final result = await _getUserProfileWithConnectyCubeIdUseCase.execute(callSession.callerId);
    result.whenWithResult((data) {
      userProfileModel = data;
      customerName = "${data.firstName} ${data.lastName}";
      notifyListeners();
    }, (map) {

    });
    // getUserById(callSession.callerId).then((cubeUser) {
    //   customerName = cubeUser.fullName ?? cubeUser.id.toString();
    //   notifyListeners();
    // }).catchError((error) {});
  }
}
