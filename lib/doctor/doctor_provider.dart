import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/usecase/get_doctor_list_use_case.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends BaseProvider with ChangeNotifier {

  GetDoctorListUseCase _getDoctorListUseCase;

  DoctorProvider(this._getDoctorListUseCase);

  List<DoctorInfoModel> listDoctor;

  Future<void> getDoctorList(BuildContext context) async {
    final result = await _getDoctorListUseCase.execute("");
    result.whenWithResult((data) {
      listDoctor = data;
      notifyListeners();
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}