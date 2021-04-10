import 'package:blossom_clinic/model/status_model.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:flutter/material.dart';

class ErrorHandle {

  void proceed(BuildContext context, StatusModel statusModel) {
    _showErrorDialog(context, statusModel);
  }

  void _showErrorDialog(BuildContext context, StatusModel statusModel) {
    showDialog(
        context: context,
      builder: (BuildContext context) => CustomDialogTwoButton(
        title: "เกิดข้อผิดพลาด",
        description: statusModel.resDesc,
        negativeButton: "",
        positiveButton: "ตกลก",
      ));
  }
}