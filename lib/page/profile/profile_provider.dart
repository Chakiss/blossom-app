import 'dart:io';

import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/get_download_url_from_cloud_storage_use_case.dart';
import 'package:blossom_clinic/usecase/get_user_profile_use_case.dart';
import 'package:blossom_clinic/usecase/upload_profile_picture_use_case.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileProvider extends BaseProvider with ChangeNotifier {
  FacebookAuth _facebookAuth;
  FirebaseAuth _firebaseAuth;
  UserData _userData;
  UploadProfilePictureUseCase _uploadProfilePictureUseCase;
  GetDownloadUrlFromCloudStorageUseCase _getDownloadUrlFromCloudStorageUseCase;
  GetUserProfileUseCase _getUserProfileUseCase;

  ProfileProvider(
      this._facebookAuth,
      this._firebaseAuth,
      this._userData,
      this._uploadProfilePictureUseCase,
      this._getDownloadUrlFromCloudStorageUseCase,
      this._getUserProfileUseCase);

  String imagePath;

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    CubeChatConnection.instance.destroy();
    goToSplashScreen(context);
  }

  void goToSplashScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context, RouteManager.routeSplashScreen(), (route) => false);
  }

  Future<void> syncAccountWithFacebook(BuildContext context) async {
    showProgressDialog(context);
    final result = await _facebookAuth.login();
    final AccessToken token = result.accessToken;
    final facebookAuthCredential = FacebookAuthProvider.credential(token.token);
    try {
      final linkResult = await _firebaseAuth.currentUser
          .linkWithCredential(facebookAuthCredential);
      Navigator.pop(context);
      showToast("เชื่อมต่อกับ Facebook สำเร็จ");
    } catch (e) {
      Navigator.pop(context);
      errorHandle.proceed(context, ErrorUtils.getErrorMessage(e));
    }
  }

  Future<void> openCamera(BuildContext context) async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80);
    if (imageFile == null) {
      return;
    }
    showProgressDialog(context);
    Map<String, dynamic> map = {};
    map["type"] = "patient";
    map["userID"] = _userData.userProfileModel?.userUID ?? "";
    map["dataURI"] = imageFile.toBase64();
    final result = await _uploadProfilePictureUseCase.execute(map);
    Navigator.pop(context);
    result.whenWithResult((data) {
      reloadUserProfile(context);
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  Future<void> getProfileImage() async {
    if (_userData.profileUrl == null) {
      final result = await _getDownloadUrlFromCloudStorageUseCase
          .execute(_userData.userProfileModel?.displayPhoto ?? "");
      result.whenWithResult((data) {
        _userData.profileUrl = data;
        imagePath = data;
        notifyListeners();
      }, (map) {});
    } else {
      imagePath = _userData.profileUrl;
    }
  }

  Future<void> openGallery(BuildContext context) async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80);
    if (imageFile == null) {
      return;
    }
    showProgressDialog(context);
    Map<String, dynamic> map = {};
    map["type"] = "patient";
    map["userID"] = _userData.userProfileModel?.userUID ?? "";
    map["dataURI"] = imageFile.toBase64();
    final result = await _uploadProfilePictureUseCase.execute(map);
    result.whenWithResult((data) {
      reloadUserProfile(context);
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  Future<void> reloadUserProfile(BuildContext context) async {
    final result = await _getUserProfileUseCase
        .execute(_userData.userProfileModel?.userUID ?? "");
    Navigator.pop(context);
    result.whenWithResult((data) {
      errorHandle.proceed(context, {"message": "เปลี่ยนรูปโปรไฟล์สำเร็จ"});
      _userData.profileUrl = null;
      getProfileImage();
      // imagePath = imagePath +
      //     "&timestamp=${DateFormat("yyyyMMDDHHmmss").format(data?.updatedAt?.toDate() ?? DateTime.now())}";
      // _userData.profileUrl = imagePath;
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}
