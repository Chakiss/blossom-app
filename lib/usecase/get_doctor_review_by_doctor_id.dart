import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/doctor_review_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetDoctorReviewByDoctorIdUseCase extends BaseAsyncUseCase<String, List<DoctorReviewModel>> {
  FirebaseFirestore _firestore;

  GetDoctorReviewByDoctorIdUseCase(this._firestore);

  @override
  Future<Result<List<DoctorReviewModel>>> execute(String parameter) async {
    try {
      final snapshot = await _firestore
          .collection("reviews")
          .where("doctorReference", isEqualTo: _firestore.collection("doctors").doc(parameter))
          .get();
      final list = snapshot.docs.map((e) => DoctorReviewModel.fromJson(e.id, e.data())).toList();
      return Success(list);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
