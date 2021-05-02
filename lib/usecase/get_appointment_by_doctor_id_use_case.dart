import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAppointmentByDoctorIdUseCase extends BaseAsyncUseCase<String, List<AppointmentModel>> {
  FirebaseFirestore _firestore;

  GetAppointmentByDoctorIdUseCase(this._firestore);

  @override
  Future<Result<List<AppointmentModel>>> execute(String parameter) async {
    try {
      final snapshot = await _firestore
          .collection("appointments")
          .where("doctorReference", isEqualTo: _firestore.collection("doctors").doc(parameter))
          .get();
      final list = snapshot.docs.map((e) => AppointmentModel.fromJson(e.data())).toList();
      return Success(list);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
