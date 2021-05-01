import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserProfileWithConnectyCubeIdUseCase extends BaseAsyncUseCase<int, UserProfileModel> {
  FirebaseFirestore _firestore;

  GetUserProfileWithConnectyCubeIdUseCase(this._firestore);

  @override
  Future<Result<UserProfileModel>> execute(int parameter) async {
    try {
      final snapshot = await _firestore.collection("patients").where("referenceConnectyCubeID", isEqualTo: parameter).get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first;
        UserProfileModel userProfileModel = UserProfileModel.fromJson(data.id, data.data());
        return Success(userProfileModel);
      } else {
        return Error({"message": "ไม่พบข้อมูลผู้ใช้"});
      }
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
