import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetDoctorListUseCase extends BaseAsyncUseCase<String, List<DoctorInfoModel>> {
  FirebaseFirestore _firestore;

  GetDoctorListUseCase(this._firestore);

  @override
  Future<Result<List<DoctorInfoModel>>> execute(String parameter) async {
    try {
      final snapshot = await _firestore.collection("doctors").get();
      final list = snapshot.docs
          .map((e) => DoctorInfoModel(
              createdAt: e.data()["createdAt"].toDate(),
              displayName: e.data()["displayName"],
              displayPhoto: e.data()["displayPhoto"],
              email: e.data()["email"],
              firstName: e.data()["firstName"],
              lastName: e.data()["lastName"],
              phoneNumber: e.data()["phoneNumber"],
              referenceConnectyCubeID: e.data()["referenceConnectyCubeID"],
              story: e.data()["story"],
              updatedAt: e.data()["updatedAt"].toDate(),
              doctorId: e.id))
          .toList();
      print(list);
      return Success(list ?? []);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
