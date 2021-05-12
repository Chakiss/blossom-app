import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetDoctorProfileUseCase extends BaseAsyncUseCase<String, DoctorInfoModel> {
  FirebaseFirestore _firestore;
  UserData _userData;

  GetDoctorProfileUseCase(this._firestore, this._userData);

  @override
  Future<Result<DoctorInfoModel>> execute(String parameter) async {
    try {
      final snapshot = await _firestore.collection("doctors").doc(parameter).get();
      if (snapshot.exists) {
        final result = DoctorInfoModel(
            createdAt: snapshot.data()["createdAt"].toDate(),
            displayName: snapshot.data()["displayName"],
            displayPhoto: snapshot.data()["displayPhoto"],
            email: snapshot.data()["email"],
            firstName: snapshot.data()["firstName"],
            lastName: snapshot.data()["lastName"],
            phoneNumber: snapshot.data()["phoneNumber"],
            referenceConnectyCubeID: snapshot.data()["referenceConnectyCubeID"],
            story: snapshot.data()["story"],
            updatedAt: snapshot.data()["updatedAt"].toDate(),
            doctorId: parameter);
        _userData.doctorInfoModel = result;
        return Success(result);
      } else {
        return Error({"message": "เกิดข้อผิดพลาด"});
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
