class OmiseCard {
  String object;
  String id;
  bool livemode;
  String location;
  bool deleted;
  String street1;
  String street2;
  String city;
  String state;
  String phone_number;
  String postal_code;
  String country;
  String financing;
  String bank;
  String brand;
  String fingerprint;
  String first_digits;
  String last_digits;
  String name;
  int expiration_month;
  int expiration_year;
  bool security_code_check;
  String created_at;

  OmiseCard(
      {this.object,
      this.id,
      this.livemode,
      this.location,
      this.deleted,
      this.street1,
      this.street2,
      this.city,
      this.state,
      this.phone_number,
      this.postal_code,
      this.country,
      this.financing,
      this.bank,
      this.brand,
      this.fingerprint,
      this.first_digits,
      this.last_digits,
      this.name,
      this.expiration_month,
      this.expiration_year,
      this.security_code_check,
      this.created_at});

  factory OmiseCard.fromJson(Map<String, dynamic> json) {
    return OmiseCard(
      object: json["object"],
      id: json["id"],
      livemode: json["livemode"],
      location: json["location"],
      deleted: json["deleted"],
      street1: json["street1"],
      street2: json["street2"],
      city: json["city"],
      state: json["state"],
      phone_number: json["phone_number"],
      postal_code: json["postal_code"],
      country: json["country"],
      financing: json["financing"],
      bank: json["bank"],
      brand: json["brand"],
      fingerprint: json["fingerprint"],
      first_digits: json["first_digits"],
      last_digits: json["last_digits"],
      name: json["name"],
      expiration_month: json["expiration_month"],
      expiration_year: json["expiration_year"],
      security_code_check: json["security_code_check"],
      created_at: json["created_at"],
    );
  }
}
