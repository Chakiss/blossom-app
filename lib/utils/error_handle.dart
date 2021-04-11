import 'package:blossom_clinic/model/status_model.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_one_button.dart';
import 'package:flutter/material.dart';

class ErrorHandle {

  void proceed(BuildContext context, StatusModel statusModel) {
    _showErrorDialog(context, statusModel);
  }

  void _showErrorDialog(BuildContext context, StatusModel statusModel) {
    showDialog(
        context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        title: "เกิดข้อผิดพลาด",
        description: statusModel.resDesc,
        positiveButton: "ตกลก",
        positiveListener: () {
          Navigator.pop(context);
        },
      ));
  }
}