import 'dart:io';

import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DownloadFileFromCloudStorageUseCase extends BaseAsyncUseCase<String, String> {
  
  FirebaseStorage _firebaseStorage;
  SharedPrefUtils _sharedPrefUtils;
  
  DownloadFileFromCloudStorageUseCase(this._firebaseStorage, this._sharedPrefUtils);

  @override
  Future<Result<String>> execute(String parameter)  async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/${parameter.replaceAll("/", "")}');
    String filePath = downloadToFile.path;

    try {
      await _firebaseStorage
          .ref(parameter)
          .writeToFile(downloadToFile);
      final map = _sharedPrefUtils.getMapFilePath();
      map[parameter] = filePath;
      await _sharedPrefUtils.setMapFilePath(map);
      return Success(filePath);
    } on FirebaseException catch (e) {
      return Error(ErrorUtils.getErrorMessage(e.message));
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}