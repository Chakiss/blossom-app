import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserProfileByIdUseCase extends BaseAsyncUseCase<String, UserProfileModel> {
  
  FirebaseFirestore _firestore;

  GetUserProfileByIdUseCase(this._firestore);

  @override
  Future<Result<UserProfileModel>> execute(String parameter) async {
   try {
     final snapshot = await _firestore.collection("patients").doc(parameter).get();
     if (snapshot.exists) {
       final data = snapshot;
       UserProfileModel userProfileModel = UserProfileModel.fromJson(data.id, data.data());
       return Success(userProfileModel);
     } else {
       return Success(null);
     }
   } catch (e) {
     print(e);
     return Error(ErrorUtils.getErrorMessage(e));
   }
  }
}