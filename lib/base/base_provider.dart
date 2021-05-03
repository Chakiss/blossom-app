import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/utils/error_handle.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/dialog/blossom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injector/injector.dart';
import 'package:logger/logger.dart';

class BaseProvider {
  Logger logger = Injector.appInstance.get();
  UserData userData = Injector.appInstance.get();
  ErrorHandle errorHandle = Injector.appInstance.get();

  Future<void> showToast(String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: BlossomTheme.black,
        textColor: BlossomTheme.white);
  }

  void showProgressDialog(BuildContext context) {
    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => BlossomProgressDialog());
  }
}

extension FileExtension on File {
  String toBase64() {
    Uint8List bytes = this.readAsBytesSync();
    return Uri.dataFromBytes(bytes, mimeType: "image/jpg").toString();
  }
}

extension ParamaterExtensions on String {
  String convertPhoneNumberWithoutCountryCode() {
    if (this.startsWith("+66")) {
      return this.replaceFirst("+66", "0");
    }
    if (this.startsWith("66")) {
      return this.replaceFirst("66", "0");
    }
    return this;
  }
}
