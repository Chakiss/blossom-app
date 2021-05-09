import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/usecase/review_appointment_use_case.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:flutter/material.dart';

class CustomerReviewDoctorProvider extends BaseProvider with ChangeNotifier {
  ReviewAppointmentUseCase _reviewAppointmentUseCase;
  UserData _userData;
  DoctorInfoModel _doctorInfoModel;
  AppointmentModel _appointmentModel;

  CustomerReviewDoctorProvider(
      this._reviewAppointmentUseCase, this._userData, this._doctorInfoModel, this._appointmentModel);

  Future<void> callServiceReviewAppointment(BuildContext context, String score, String comment) async {

    if (score?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message" : "กรุณาเลือกคะแนน"});
    }

    showProgressDialog(context);
    final Map<String, dynamic> request = {
      "patientID": _userData.userProfileModel.userUID,
      "doctorID": _doctorInfoModel.doctorId,
      "appointmentID": _appointmentModel.id,
      "score": score,
      "comment": comment
    };
    print(request);
    final result = await _reviewAppointmentUseCase.execute(request);
    Navigator.pop(context);
    result.whenWithResult((data) {
      showToast("รีวิวของคุณถูกบันทึกเรียบร้อยแล้ว");
      Navigator.pop(context);
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}
