import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserProfileUseCase extends BaseAsyncUseCase<String, UserProfileModel> {
  
  FirebaseFirestore _firestore;
  UserData _userData;
  
  GetUserProfileUseCase(this._firestore, this._userData);

  @override
  Future<Result<UserProfileModel>> execute(String parameter) async {
   try {
     final snapshot = await _firestore.collection("patients").doc(parameter).get();
     if (snapshot.exists) {
       final data = snapshot;
       UserProfileModel userProfileModel = UserProfileModel.fromJson(data.id, data.data());
       _userData.userProfileModel = userProfileModel;
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