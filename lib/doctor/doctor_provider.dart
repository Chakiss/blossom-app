import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends BaseProvider with ChangeNotifier {

  RemoteRepository _remoteRepository;
  List<DoctorInfo> doctorList = [];

  DoctorProvider(this._remoteRepository);

  Future<void> callServiceGetDoctorList(BuildContext context) async {
    var result = await _remoteRepository.getDoctorList();
    result.whenWithResult((data) {
      doctorList = data;
      notifyListeners();
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }
}