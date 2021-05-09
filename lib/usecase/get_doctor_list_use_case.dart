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
          .map((e) => DoctorInfoModel.fromJson(e.id, e.data()))
          .toList();
      print(list);
      return Success(list ?? []);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
