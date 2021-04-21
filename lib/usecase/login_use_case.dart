import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase extends BaseUseCase<Map<String, String>, UserCredential> {

  FirebaseAuth _firebaseAuth;

  LoginUseCase(this._firebaseAuth);

  @override
  Future<Result<UserCredential>> execute(Map<String, String> parameter) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: parameter["email"],
          password: parameter["password"]
      );
      return Success(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Error({"message" : "อีเมล์หรือรหัสผ่านไม่ถูกต้อง"});
      } else if (e.code == 'wrong-password') {
        return Error({"message" : "อีเมล์หรือรหัสผ่านไม่ถูกต้อง"});
      } else {
        return Error({"message" : "ไม่สามารถเข้าสู่ระบบได้"});
      }
    } catch (e) {
      print(e);
      return Error({"message" : "ไม่สามารถเข้าสู่ระบบได้"});
    }
  }

}