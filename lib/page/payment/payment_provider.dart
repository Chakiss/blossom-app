import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/page/webview/web_view_page.dart';
import 'package:blossom_clinic/usecase/omise_internet_banking_charge_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_one_button.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends BaseProvider with ChangeNotifier {

  OmiseInternetBankingChargeUseCase _omiseInternetBankingChargeUseCase;

  PaymentProvider(this._omiseInternetBankingChargeUseCase);

  Future<void> callServiceOmiseCharge(BuildContext context, String sourceType, String orderId, int amount) async {
    showProgressDialog(context);
    final Map<String, dynamic> request = {
      "amount": amount * 100,
      "orderID": orderId,
      "sourceType": sourceType,
    };
    final result = await _omiseInternetBankingChargeUseCase.execute(request);
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