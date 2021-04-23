import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerOrderModel {
  DateTime createdAt;
  int discount;
  DocumentReference doctorReference;
  String paymentGateway;
  String paymentMethod;
  String paymentReference;
  int status;
  String systemNoted;
  int total;
  int totalItemsDiscount;
  int totalItemsPrice;
  int type;
  DateTime updatedAt;
  String userNoted;

  CustomerOrderModel(
      {this.createdAt,
      this.discount,
      this.doctorReference,
      this.paymentGateway,
      this.paymentMethod,
      this.paymentReference,
      this.status,
      this.systemNoted,
      this.total,
      this.totalItemsDiscount,
      this.totalItemsPrice,
      this.type,
      this.updatedAt,
      this.userNoted});
}
