import 'package:blossom_clinic/widget/dialog/custom_dialog_one_button.dart';
import 'package:flutter/material.dart';

class ErrorHandle {

  void proceed(BuildContext context, Map<String, String> map) {
    _showErrorDialog(context, map);
  }

  void _showErrorDialog(BuildContext context, Map<String, String> map) {
    String message = map["message"] ?? "";
    if (message.contains("The email address is already in use by another account")) {
      message = "email นี้ถูกใช้โดยผู้ใช้งานคนอื่นแล้ว กรุณากรอก email ใหม่";
    }
    if (message.contains("The user with the provided phone number already exists")) {
      message = "เบอร์โทรศัพท์นี้ถูกใช้โดยผู้ใช้งานคนอื่นแล้ว กรุณากรอกเบอร์โทรศัพท์ใหม่";
    }
    if (message.contains("An account already exists with the same email address but different sign-in credentials")) {
      message = "email ของ Facebook นี้ถูกใช้ลงทะเบียนโดยรูปแบบปกติไปแล้ว กรุณาเข้าสู่ระบบด้วย email ของ Facebook นี้ด้วยวิธีการปกติ";
    }
    showDialog(
        context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        title: "เกิดข้อผิดพลาด",
        description: message,
        positiveButton: "ตกลง",
        positiveListener: () {
          Navigator.pop(context);
        },
      ));
  }
}