
import 'package:blossom_clinic/model/omise_card.dart';

class OmiseAddCardResponseModel {

  String object;
  String id;
  bool livemode;
  String location;
  bool used;
  String charge_status;
  OmiseCard card;
  String created_at;

  OmiseAddCardResponseModel({this.object, this.id, this.livemode, this.location, this.used, this.charge_status,
      this.card, this.created_at});

  factory OmiseAddCardResponseModel.fromJson(Map<String, dynamic> json) {
    return OmiseAddCardResponseModel(
      object: json["object"],
      id: json["id"],
      livemode: json["livemode"],
      location: json["location"],
      used: json["used"],
      charge_status: json["charge_status"],
      card: OmiseCard.fromJson(json["card"]),
      created_at: json["created_at"],
    );
  }
}