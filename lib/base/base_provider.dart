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
    showDialog(
        context: context,
        builder: (BuildContext context) => BlossomProgressDialog()
    );
  }
}