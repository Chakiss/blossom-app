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
     print(snapshot.data());
     final data = snapshot;
     UserProfileModel userProfileModel = UserProfileModel(
       userUID: parameter,
       acneCaredNoted: data["acneCaredNoted"],
       acneIsCared: data["acneIsCared"],
       acneTypes: data["acneTypes"].cast<int>(),
       birthDate: data["birthDate"].toDate(),
       createdAt: data["createdAt"].toDate(),
       drugAllergyItems: data["drugAllergyItems"].cast<String>(),
       drugAllergyStatus: data["drugAllergyStatus"],
       email: data["email"],
       firstName: data["firstName"],
       lastName: data["lastName"],
       phoneNumber: data["phoneNumber"],
       registeredChannel: data["registeredChannel"],
       registeredNote: data["registeredNote"],
       skinType: data["skinType"],
       updatedAt: data["updatedAt"].toDate(),
     );
     _userData.userProfileModel = userProfileModel;
     return Success(userProfileModel);
   } catch (e) {
     print(e);
     return Error(ErrorUtils.getErrorMessage(e));
   }
  }
}