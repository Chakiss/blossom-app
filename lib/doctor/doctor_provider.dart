import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class DoctorProvider extends BaseProvider with ChangeNotifier {
  
  RemoteRepository remoteRepository = Injector.appInstance.get();
  List<DoctorInfo> doctorList = [];

  Future<void> callServiceGetDoctorList() async {
    var result = await remoteRepository.getDoctorList();
    result.whenWithResult((data) {
      doctorList = data;
      notifyListeners();
    }, (statusModel) {

    });
  }
}