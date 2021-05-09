import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/doctor_review_model.dart';
import 'package:blossom_clinic/usecase/get_doctor_review_by_doctor_id.dart';
import 'package:flutter/material.dart';

class DoctorReviewProvider extends BaseProvider with ChangeNotifier {

  GetDoctorReviewByDoctorIdUseCase _getDoctorReviewByDoctorIdUseCase;
  String _doctorId;

  DoctorReviewProvider(this._getDoctorReviewByDoctorIdUseCase, this._doctorId);
  List<DoctorReviewModel> list;

  Future<void> callServiceGetDoctorReview() async {
    final result = await _getDoctorReviewByDoctorIdUseCase.execute(_doctorId);
    result.whenWithResult((data) {
      list = data;
      notifyListeners();
    }, (map) {
      list = [];
      notifyListeners();
    });
  }
}