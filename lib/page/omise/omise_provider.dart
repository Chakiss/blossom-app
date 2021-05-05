import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/page/webview/web_view_page.dart';
import 'package:blossom_clinic/usecase/omise_charge_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_one_button.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:flutter/material.dart';

class OmiseProvider extends BaseProvider with ChangeNotifier {
  OmiseChargeUseCase _chargeOmiseUseCase;

  OmiseProvider(this._chargeOmiseUseCase);

  Future<void> proceedCharge(BuildContext context, String cardNo, String name, String expireMonth,
      String expireYear, String cvv, String orderId, int amount) async {
    if (cardNo == null || cardNo.length < 16) {
      errorHandle.proceed(context, {"message": "กรุณากรอกหมายเลขบัตรให้ถูกต้อง"});
      return;
    }
    if (expireMonth?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกเดือนหมดอายุ"});
      return;
    }
    if (expireMonth == "MM") {
      errorHandle.proceed(context, {"message": "กรุณาเลือกเดือนหมดอายุ"});
      return;
    }
    if (expireYear?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณาเลือกปีหมดอายุ"});
      return;
    }
    if (expireYear == "YY") {
      errorHandle.proceed(context, {"message": "กรุณาเลือกปีหมดอายุ"});
      return;
    }
    if (cvv?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกรหัสความปลอดภัยของบัตร"});
      return;
    }
    if (cvv == "XXX") {
      errorHandle.proceed(context, {"message": "กรุณากรอกรหัสความปลอดภัยของบัตร"});
      return;
    }
    if (name?.isEmpty ?? true) {
      errorHandle.proceed(context, {"message": "กรุณากรอกชื่อ"});
      return;
    }

    _showConfirmDialog(
        context,
        cardNo,
        name,
        expireMonth,
        expireYear,
        cvv,
        orderId,
        amount);
  }

  void _showConfirmDialog(BuildContext context, String cardNo, String name, String expireMonth, String expireYear,
      String cvv, String orderId, int amount) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomDialogTwoButton(
            title: "ยืนยัน",
            description: "คุณต้องการชำระค่าจองคิวเป็นจำนวนเงิน $amount บาท",
            positiveButton: "ตกลง",
            positiveListener: () {
              Navigator.pop(dialogContext);
              _callServiceOmiseCharge(
                  context,
                  cardNo,
                  name,
                  expireMonth,
                  expireYear,
                  cvv,
                  orderId,
                  amount);
            },
            negativeButton: "ยกเลิก",
            negativeListener: () {
              Navigator.pop(dialogContext);
            });
      },
    );
  }

  Future<void> _callServiceOmiseCharge(BuildContext context, String cardNo, String name, String expireMonth,
      String expireYear, String cvv, String orderId, int amount) async {
    showProgressDialog(context);
    final Map<String, dynamic> request = {
      "amount": amount * 100 * 100,
      "orderID": orderId,
      "cardNo": cardNo,
      "name": name,
      "expireMonth": expireMonth,
      "expireYear": expireYear,
      "cvv": cvv,
    };
    final result = await _chargeOmiseUseCase.execute(request);
    Navigator.pop(context);
    result.whenWithResult((data) async {
      final String authorizeUrl = data["authorize_uri"];
      if (authorizeUrl.isEmpty ?? true) {
        _showSuccessDialog(context, orderId);
      } else {
        bool isSuccess = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return WebViewPage("Omise 3d Secure", authorizeUrl);
        }));
        if (isSuccess) {
          _showSuccessDialog(context, orderId);
        } else {
          errorHandle.proceed(context, {"message" : "การชำระเงินล้มเหลว กรุณาลองใหม่อีกครั้ง"});
        }
      }
    }, (map) {
      errorHandle.proceed(context, map);
    });
  }

  void _showSuccessDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomDialogOneButton(
            title: "สำเร็จ",
            description: "คุณได้ชำระค่าจองเป็นจำนวนเงิน 100 บาทเรียบร้อยแล้ว",
            positiveButton: "ตกลง",
            positiveListener: () {
              Navigator.pop(dialogContext);
              _goToMainPage(context, orderId);
            });
      },
    );
  }

  void _goToMainPage(BuildContext context, String orderId) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeMain(), (route) => false);
    Navigator.push(context, RouteManager.routeAddCustomerInformation(orderId));
  }
}
