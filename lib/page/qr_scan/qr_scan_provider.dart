import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QrScanProvider extends BaseProvider with ChangeNotifier {

  String orderId;
  FirebaseFirestore _firestore;

  QrScanProvider(this.orderId, this._firestore);

  void observeOrderWhenPayment(BuildContext context) {
    print(orderId);
    _firestore.collection("orders").doc(orderId).snapshots().listen((event) {
      if (event.data()["status"] == 1) {
        showToast("ชำระเงินสำเร็จ ระบบกำลังนำคุณไปหน้ากรอกข้อมูลประกอบการรักษา");
        _goToMainPage(context, orderId);
      }
    });
  }

  void _goToMainPage(BuildContext context, String orderId) {
    Navigator.pushAndRemoveUntil(context, RouteManager.routeMain(), (route) => false);
    Navigator.push(context, RouteManager.routeAddCustomerInformation(orderId));
  }
}