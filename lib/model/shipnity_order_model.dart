class ShipnityOrderModel {

  int id;
  String invoice_number;
  String price;
  bool paid;
  String summary_text;
  String annotation;
  bool payment_accepted;
  bool payment_rejected;
  List<Purchase> purchases;

  ShipnityOrderModel({this.id, this.invoice_number, this.price, this.paid, this.summary_text, this.annotation,
      this.payment_accepted, this.payment_rejected, this.purchases});

  factory ShipnityOrderModel.fromJson(Map<String, dynamic> json) {
    return ShipnityOrderModel(
      id: json["id"],
      invoice_number: json["invoice_number"],
      price: json["price"],
      paid: json["paid"],
      summary_text: json["summary_text"],
      annotation: json["annotation"],
      payment_accepted: json["payment_accepted"],
      payment_rejected: json["payment_rejected"],
      purchases: (json["purchases"] as List).map((e) => Purchase.fromJson(e)).toList(),
    );
  }
}

class Purchase {
  int id;
  String code;
  String name;
  int quantity;
  String discount;
  String price;
  int subproduct_id;
  String thumb;
  int object_available;

  Purchase({this.id, this.code, this.name, this.quantity, this.discount, this.price, this.subproduct_id, this.thumb,
      this.object_available});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      quantity: json["quantity"],
      discount: json["discount"],
      price: json["price"],
      subproduct_id: json["subproduct_id"],
      thumb: json["thumb"],
      object_available: json["object_available"],
    );
  }
}