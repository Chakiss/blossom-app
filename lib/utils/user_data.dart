import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';

class UserData {

  SharedPrefUtils _sharedPrefUtils;

  UserData(this._sharedPrefUtils);

  UserProfileModel userProfileModel;

  String getImagePathFromLocal(String imageKey) {
    return _sharedPrefUtils.getMapFilePath()[imageKey] ?? "";
  }
}