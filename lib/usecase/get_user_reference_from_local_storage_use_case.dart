import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserReferenceFromLocalStorageUseCase extends BaseAsyncUseCase<DocumentReference, String> {

  SharedPrefUtils _sharedPrefUtils;

  GetUserReferenceFromLocalStorageUseCase(this._sharedPrefUtils);

  @override
  Future<Result<String>> execute(DocumentReference parameter) async {
    try {
      final mapUserReference = _sharedPrefUtils.getMapUserReference();
      if (mapUserReference.containsKey(parameter.path)) {
        return Success(mapUserReference[parameter.path]);
      } else {
        final snapshot = await parameter.get();
        final profileModel = UserProfileModel.fromJson(parameter.id, snapshot.data());
        final name = "${profileModel.firstName} ${profileModel.lastName}";
        mapUserReference[parameter.path] = name;
        _sharedPrefUtils.setMapUserReference(mapUserReference);
        return Success(name);
      }
    } catch (e) {
      return Success("");
    }
  }

}