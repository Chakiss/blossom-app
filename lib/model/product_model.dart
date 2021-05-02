import 'package:blossom_clinic/model/sub_product_model.dart';

class ProductModel {

  int id;
  int product_id;
  String name;
  String code;
  double object_price;
  int inventory;
  String description_long;
  String description_short;
  int reserved;
  int object_available;
  String image;
  String image_thumb;
  String price;
  List<SubProductModel> subproducts;

  ProductModel({this.id, this.product_id, this.name, this.code, this.object_price, this.inventory, this.description_long,
      this.description_short, this.reserved, this.object_available, this.image, this.image_thumb, this.price, this.subproducts});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      product_id: json["product_id"],
      name: json["name"],
      code: json["code"],
      object_price: json["object_price"],
      inventory: json["inventory"],
      description_long: json["description_long"],
      description_short: json["description_short"],
      reserved: json["reserved"],
      object_available: json["object_available"],
      image: json["image"],
      image_thumb: json["image_thumb"],
      price: json["price"],
      subproducts: (json["subproducts"] as List).map((e) => SubProductModel.fromJson(e)).toList()
    );
  }
}