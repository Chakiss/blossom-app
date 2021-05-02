import 'package:blossom_clinic/model/purchases_attributes_model.dart';

class CreateShipnityOrderRequestModel {
  CreateShipnityOrder order;

  CreateShipnityOrderRequestModel({this.order});

  Map<String, dynamic> toJson() {
    return {"order": order.toJson()};
  }
}

class CreateShipnityOrder {

  int customer;
  String name;
  String address;
  String tel;
  String contact_method;
  String email;
  String annotation;
  String tag;
  String shipping_type;
  int shipping_fee;
  bool preorder;
  bool taxable;
  int order_discount;
  List<PurchasesAttributesModel> purchases_attributes;


  CreateShipnityOrder({
      this.customer,
      this.name,
      this.address,
      this.tel,
      this.contact_method,
      this.email,
      this.annotation,
      this.tag,
      this.shipping_type,
      this.shipping_fee,
      this.preorder,
      this.taxable,
      this.order_discount,
      this.purchases_attributes});

  Map<String, dynamic> toJson() {
    return {
      "customer" : customer,
      "name" : name,
      "address" : address,
      "tel" : tel,
      "contact_method" : contact_method,
      "email" : email,
      "annotation" : annotation,
      "tag" : tag,
      "shipping_type" : shipping_type,
      "shipping_fee" : shipping_fee,
      "preorder" : preorder,
      "taxable" : taxable,
      "order_discount" : order_discount,
      "purchases_attributes" : purchases_attributes.map((e) => e.toJson()).toList()
    };
  }
}
