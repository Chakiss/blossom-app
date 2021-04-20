import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/status_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUseCase extends BaseUseCase<Map<String, String>, StatusModel> {
  FirebaseAuth _firebaseAuth;

  RegisterUseCase(this._firebaseAuth);

  @override
  Future<Result<StatusModel>> execute(Map<String, String> parameter) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: parameter["email"], password: parameter["password"]);
      return Success(StatusModel("0", "S", "The password provided is too weak."));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Error(StatusModel("0001", "E", "รหัสผ่านของคุณง่ายเกินไป กรุณากรอกใหม่อีกครั้ง"));
      } else if (e.code == 'email-already-in-use') {
        return Error(StatusModel("0001", "E", "อีเมล์นี้ได้ถูกใช้งานไปแล้ว กรุณากรอกใหม่อีกครั้ง"));
      } else {
        return Error(StatusModel("0001", "E", e.message));
      }
    } catch (e) {
      print(e);
      return Error(StatusModel("9999", "E", "Exception"));
    }
  }
}
