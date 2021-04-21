import 'dart:io';

import 'package:blossom_clinic/base/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCustomerInformationProvider extends BaseProvider with ChangeNotifier {

  List<File> listFile = [null, null, null];

  AddCustomerInformationProvider();

  Future<void> openCamera(int index) async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    listFile[index] = imageFile;
    notifyListeners();
  }

  Future<void> confirmConsult(BuildContext context) async {

  }
}