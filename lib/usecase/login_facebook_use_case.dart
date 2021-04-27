import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginFacebookUseCase extends BaseAsyncUseCase<String, UserCredential> {
  
  FacebookAuth _facebookAuth;
  FirebaseAuth _firebaseAuth;
  
  LoginFacebookUseCase(this._facebookAuth, this._firebaseAuth);

  @override
  Future<Result<UserCredential>> execute(String parameter) async {
    try {
      final result = await _facebookAuth.login();
      final AccessToken token = result.accessToken;
      final facebookAuthCredential = FacebookAuthProvider.credential(token.token);
      final userCredential = await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      return Success(userCredential);
    } catch(e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
  
}