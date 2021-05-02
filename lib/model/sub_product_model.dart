class SubProductModel {

  int id;
  String name;
  String code;
  int inventory;
  int reserved;
  int available;
  String barcode;
  String price;
  double object_price;
  int object_available;


  SubProductModel({this.id, this.name, this.code, this.inventory, this.reserved, this.available, this.barcode,
      this.price, this.object_price, this.object_available});

  factory SubProductModel.fromJson(Map<String, dynamic> json) {
    return SubProductModel(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      inventory: json["inventory"],
      reserved: json["reserved"],
      available: json["available"],
      barcode: json["barcode"],
      price: json["price"],
      object_price: json["object_price"],
      object_available: json["object_available"],
    );
  }
}