class CreateShipnityCustomerRequestModel {
  CreateShipnityCustomer customer;

  CreateShipnityCustomerRequestModel(this.customer);

  Map<String, dynamic> toJson() {
    return {"customer": customer.toJson()};
  }
}

class CreateShipnityCustomer {
  String name;
  String address;
  String tel;
  String contact_method;
  String email;
  String tag;

  CreateShipnityCustomer({this.name, this.address, this.tel, this.contact_method, this.email, this.tag});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "tel": tel,
      "contact_method": contact_method,
      "email": email,
      "tag": tag,
    };
  }
}
