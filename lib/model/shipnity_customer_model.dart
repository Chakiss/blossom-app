class ShipnityCustomerModel {
  int id;
  String name;
  String tag;
  String address;
  String address_without_zipcode;
  String postcode;
  String contact_method;
  String tel;
  String email;
  String customer_number;

  ShipnityCustomerModel(
      {this.id,
      this.name,
      this.tag,
      this.address,
      this.address_without_zipcode,
      this.postcode,
      this.contact_method,
      this.tel,
      this.email,
      this.customer_number});

  factory ShipnityCustomerModel.fromJson(Map<String, dynamic> json) {
    return ShipnityCustomerModel(
      id: json["id"],
      name: json["name"],
      tag: json["tag"],
      address: json["address"],
      address_without_zipcode: json["address_without_zipcode"],
      postcode: json["postcode"],
      contact_method: json["contact_method"],
      tel: json["tel"],
      email: json["email"],
      customer_number: json["customer_number"],
    );
  }
}
