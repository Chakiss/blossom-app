import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckLoginUseCase extends BaseUseCase<Function(bool), bool> {

  FirebaseAuth _firebaseAuth;

  CheckLoginUseCase(this._firebaseAuth);

  @override
  Future<Result<bool>> execute(Function(bool isLogin) parameter) async {
    _firebaseAuth.authStateChanges().listen((event) {
        if (event != null) {
          parameter.call(true);
        } else {
          parameter.call(false);
        }
    });
    return Success(true);
  }
}