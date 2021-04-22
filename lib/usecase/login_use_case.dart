import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/usecase/validate_email_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase extends BaseAsyncUseCase<Map<String, String>, UserCredential> {
  FirebaseAuth _firebaseAuth;
  ValidateEmailUseCase _validateEmailUseCase;

  LoginUseCase(this._firebaseAuth, this._validateEmailUseCase);

  @override
  Future<Result<UserCredential>> execute(Map<String, String> parameter) async {
    try {
      final email = parameter["email"] ?? "";
      final password = parameter["password"] ?? "";
      if (email.isEmpty || password.isEmpty) {
        return Error({"message": "กรุณากรอก email และ password"});
      }
      if (!(_validateEmailUseCase.execute(email) as Success<bool>).data) {
        return Error({"message": "กรุณากรอกอีเมล์ให้ถูกต้อง"});
      }
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return Success(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Error({"message": "อีเมล์หรือรหัสผ่านไม่ถูกต้อง"});
      } else if (e.code == 'wrong-password') {
        return Error({"message": "อีเมล์หรือรหัสผ่านไม่ถูกต้อง"});
      } else {
        return Error({"message": "ไม่สามารถเข้าสู่ระบบได้"});
      }
    } catch (e) {
      print(e);
      return Error({"message": "ไม่สามารถเข้าสู่ระบบได้"});
    }
  }
}
