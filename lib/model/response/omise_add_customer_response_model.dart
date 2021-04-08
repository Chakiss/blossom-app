import 'package:blossom_clinic/model/omise_card_model.dart';


class OmiseAddCustomerResponseModel {

  String object;
  String id;
  bool livemode;
  String location;
  bool deleted;
  String metadata;
  OmiseCardModel cards;
  // dynamic default_card;
  String description;
  String email;
  String created_at;


  OmiseAddCustomerResponseModel({this.object, this.id, this.livemode, this.location, this.deleted, this.metadata,
      this.cards, this.description, this.email, this.created_at});

  Map<String, dynamic> toJson() {
    return {
      "object": object,
      "id": id,
      "livemode": livemode,
      "location": location,
      "deleted": deleted,
      // "metadata": metadata,
      // "cards": jsonEncode(cards),
      "description": description,
      "email": email,
      "created_at": created_at,
    };
  }

  factory OmiseAddCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return OmiseAddCustomerResponseModel(
        object: json["object"],
        id: json["id"],
        livemode: json["livemode"],
        location: json["location"],
        deleted: json["deleted"],
        // metadata: json["metadata"],
        cards: OmiseCardModel.fromJson(json["cards"]),
        description: json["description"],
        email: json["email"],
        created_at: json["created_at"],
    );
  }
}

// {
// "object": "customer",
// "id": "cust_test_5n8f3o4j2c3zxwjo4n5",
// "livemode": false,
// "location": "/customers/cust_test_5n8f3o4j2c3zxwjo4n5",
// "deleted": false,
// "metadata": {},
// "cards": {
//   "object": "list",
//   "data": [],
//   "limit": 20,
//   "offset": 0,
//   "total": 0,
//   "location": "/customers/cust_test_5n8f3o4j2c3zxwjo4n5/cards",
//   "order": "chronological",
//   "from": "1970-01-01T00:00:00Z",
//   "to": "2021-03-19T17:58:49Z"
// },
// "default_card": null,
// "description": "Prew Sitthirat",
// "email": "prewaraiiwa@gmail.com",
// "created_at": "2021-03-19T17:58:49Z"
// }