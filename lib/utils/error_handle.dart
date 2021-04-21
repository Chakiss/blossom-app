import 'package:blossom_clinic/widget/dialog/custom_dialog_one_button.dart';
import 'package:flutter/material.dart';

class ErrorHandle {

  void proceed(BuildContext context, Map<String, String> map) {
    _showErrorDialog(context, map);
  }

  void _showErrorDialog(BuildContext context, Map<String, String> map) {
    showDialog(
        context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        title: "เกิดข้อผิดพลาด",
        description: map["message"],
        positiveButton: "ตกลก",
        positiveListener: () {
          Navigator.pop(context);
        },
      ));
  }
}