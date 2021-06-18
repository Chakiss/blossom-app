import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordUseCase extends BaseAsyncUseCase<String, dynamic> {
  FirebaseAuth _firebaseAuth;

  ForgotPasswordUseCase(this._firebaseAuth);

  @override
  Future<Result> execute(String parameter) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: parameter);
      return Success(null);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
