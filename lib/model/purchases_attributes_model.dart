class PurchasesAttributesModel {

  int id;
  int subproduct_id;
  int quantity;
  int price;
  int discount;

  PurchasesAttributesModel({this.id, this.subproduct_id, this.quantity, this.price, this.discount});

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "subproduct_id" : subproduct_id,
      "quantity" : quantity,
      "price" : price,
      "discount" : discount,
    };
  }
}