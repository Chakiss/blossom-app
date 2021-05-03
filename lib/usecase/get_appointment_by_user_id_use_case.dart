import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAppointmentByUserIdUseCase extends BaseAsyncUseCase<String, List<AppointmentModel>> {
  FirebaseFirestore _firestore;

  GetAppointmentByUserIdUseCase(this._firestore);

  @override
  Future<Result<List<AppointmentModel>>> execute(String parameter) async {
    try {
      final snapshot = await _firestore
          .collection("appointments")
          .where("userReference", isEqualTo: _firestore.collection("patients").doc(parameter))
          .get();
      final list = snapshot.docs.map((e) => AppointmentModel.fromJson(e.id, e.data())).toList();
      return Success(list);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
