import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAppointmentsIdByOrderIdUseCase extends BaseAsyncUseCase<String, String> {

  FirebaseFirestore _firestore;

  GetAppointmentsIdByOrderIdUseCase(this._firestore);

  @override
  Future<Result<String>> execute(String parameter) async {
    try {
      final snapshot = await _firestore.collection("appointments").where("orderReference", isEqualTo: _firestore.collection("orders").doc(parameter)).get();
      if (snapshot.docs.isNotEmpty) {
        return Success(snapshot.docs.first.id);
      } else {
        return Error(ErrorUtils.getErrorMessage("not found appointments id"));  
      }
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

}