import 'dart:io';

import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/request/save_patient_form_request_model.dart';
import 'package:blossom_clinic/usecase/get_appointments_id_by_order_id_use_case.dart';
import 'package:blossom_clinic/usecase/save_patient_form_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCustomerInformationProvider extends BaseProvider with ChangeNotifier {
  SavePatientFormUseCase _savePatientFormUseCase;
  GetAppointmentsIdByOrderIdUseCase _getAppointmentsIdByOrderIdUseCase;
  List<File> listFile = [null, null, null];

  AddCustomerInformationProvider(this._savePatientFormUseCase, this._getAppointmentsIdByOrderIdUseCase);

  Future<void> openCamera(int index) async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600, maxHeight: 600, imageQuality: 80);
    listFile[index] = imageFile;
    notifyListeners();
  }

  Future<void> confirmPatientForm(
      BuildContext context,
      String orderId,
      String acnePeriod,
      String acneCared,
      String changeProduct,
      bool isStressed,
      bool sleepDeprivation,
      bool normalMenstruation,
      bool frequenceSweet) async {
    showProgressDialog(context);
    final appointmentsIdResult = await _getAppointmentsIdByOrderIdUseCase.execute(orderId);
    appointmentsIdResult.whenWithResult((appointmentsId) async {
      _callSavePatientForm(context, appointmentsId, acnePeriod, acneCared, changeProduct, isStressed, sleepDeprivation,
          normalMenstruation, frequenceSweet);
    }, (map) {
      Navigator.pop(context);
      errorHandle.proceed(context, map);
    });
  }

  Future<void> _callSavePatientForm(
      BuildContext context,
      String appointmentId,
      String acnePeriod,
      String acneCared,
      String changeProduct,
      bool isStressed,
      bool sleepDeprivation,
      bool normalMenstruation,
      bool frequenceSweet) async {
    
    List<String> images = [];
    listFile.forEach((element) async {
      if (element != null) {
        final base64String = element.toBase64();
        images.add(base64String);
      }
    });
    
    final requestModel = SavePatientFormRequestModel(
      appointmentID: appointmentId,
      acnePeriod: acnePeriod,
      acneCared: acneCared,
      changeProduct: changeProduct,
      isStressed: isStressed,
      sleepDeprivation: sleepDeprivation,
      normalMenstruation: normalMenstruation,
      frequenceSweet: frequenceSweet,
      images: images,
    );
    final result = await _savePatientFormUseCase.execute(requestModel);
    Navigator.pop(context);
    result.whenWithResult((data) {
      Navigator.push(context, RouteManager.routeMain(initIndex: 1));
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }
}
