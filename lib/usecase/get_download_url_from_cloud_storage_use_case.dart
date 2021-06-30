import 'dart:io';

import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GetDownloadUrlFromCloudStorageUseCase extends BaseAsyncUseCase<String, String> {
  
  FirebaseStorage _firebaseStorage;

  GetDownloadUrlFromCloudStorageUseCase(this._firebaseStorage);

  @override
  Future<Result<String>> execute(String parameter)  async {
    try {
      final downloadUrl = await _firebaseStorage
          .ref(parameter)
          .getDownloadURL();
      return Success(downloadUrl);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}