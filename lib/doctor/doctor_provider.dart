import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends BaseProvider with ChangeNotifier {

  List<DoctorInfo> doctorList = [];

  Future<void> callServiceGetDoctorList(BuildContext context) async {
    var result = await remoteRepository.getDoctorList();
    result.whenWithResult((data) {
      doctorList = data;
      notifyListeners();
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }
}