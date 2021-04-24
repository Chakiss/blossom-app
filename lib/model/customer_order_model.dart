import 'package:blossom_clinic/model/order_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerOrderModel {
  String orderId;
  DateTime createdAt;
  int discount;
  DocumentReference doctorReference;
  List<OrderItemModel> items;
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
      {this.orderId,
      this.createdAt,
      this.discount,
      this.doctorReference,
      this.items,
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

  factory CustomerOrderModel.fromJson(String id, Map<String, dynamic> json) {
    return CustomerOrderModel(
      orderId: id,
      createdAt: json["createdAt"].toDate(),
      discount: json["discount"],
      doctorReference: json["doctorReference"],
      items: (json["items"] as List).map((data) =>
          OrderItemModel.fromJson(data)).toList(),
      paymentGateway: json["paymentGateway"],
      paymentMethod: json["paymentMethod"],
      paymentReference: json["paymentReference"],
      status: json["status"],
      systemNoted: json["systemNoted"],
      total: json["total"],
      totalItemsDiscount: json["totalItemsDiscount"],
      totalItemsPrice: json["totalItemsPrice"],
      type: json["type"],
      updatedAt: json["updatedAt"].toDate(),
      userNoted: json["userNoted"],
    );
  }
}
