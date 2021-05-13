import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetDoctorProfileWithConnectyCubeIdUseCase extends BaseAsyncUseCase<int, DoctorInfoModel> {
  FirebaseFirestore _firestore;

  GetDoctorProfileWithConnectyCubeIdUseCase(this._firestore);

  @override
  Future<Result<DoctorInfoModel>> execute(int parameter) async {
    try {
      final snapshot = await _firestore.collection("doctors").where("referenceConnectyCubeID", isEqualTo: parameter).get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first;
        DoctorInfoModel userProfileModel = DoctorInfoModel.fromJson(data.id, data.data());
        return Success(userProfileModel);
      } else {
        return Error({"message": "ไม่พบข้อมูลผู้ใช้"});
      }
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
