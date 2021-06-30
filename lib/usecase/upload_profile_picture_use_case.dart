import 'dart:io';

import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class UploadProfilePictureUseCase extends BaseAsyncUseCase<Map<String, dynamic>, String> {

  FirebaseFunctions _firebaseFunctions;

  UploadProfilePictureUseCase(this._firebaseFunctions);

  @override
  Future<Result<String>> execute(Map<String, dynamic> map) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("users-uploadDisplayPhoto");
      final result = await callable.call(map);
      return Success("");
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}