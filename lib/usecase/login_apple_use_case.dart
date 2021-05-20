import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginAppleUseCase extends BaseAsyncUseCase<String, Map<String, dynamic>> {
  FirebaseAuth _firebaseAuth;

  LoginAppleUseCase(this._firebaseAuth);

  @override
  Future<Result<Map<String, dynamic>>> execute(String parameter) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "com.blossomclinic.app",
          redirectUri: Uri.parse(
            'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
          ),
        ),
      );

      final AuthCredential credential = OAuthProvider("apple.com")
          .credential(accessToken: appleCredential.authorizationCode, idToken: appleCredential.identityToken);

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      Map<String, dynamic> mapResult = {"appleCredential": appleCredential, "userCredential": userCredential};
      return Success(mapResult);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
