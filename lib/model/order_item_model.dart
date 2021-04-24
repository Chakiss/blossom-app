import 'package:blossom_clinic/model/order_reference_model.dart';

class OrderItemModel {
  int discount;
  String noted;
  int price;
  int priceCost;
  int priceSale;
  OrderReferenceModel references;
  String title;

  OrderItemModel({this.discount, this.noted, this.price, this.priceCost, this.priceSale, this.references, this.title});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
        discount: json["discount"],
        noted: json["noted"],
        price: json["price"],
        priceCost: json["priceCost"],
        priceSale: json["priceSale"],
        references: OrderReferenceModel.fromJson(json["references"]),
        title: json["title"]);
  }
}
