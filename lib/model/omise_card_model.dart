import 'package:blossom_clinic/model/omise_card.dart';

class OmiseCardModel {

  String object;
  List<OmiseCard> data;
  int limit;
  int offset;
  int total;
  String location;
  String order;
  String from;
  String to;

  OmiseCardModel({this.object, this.data, this.limit, this.offset, this.total, this.location, this.order, this.from,
    this.to});

  Map<String, dynamic> toJson() {
    return {
      "object": object,
      "limit": limit,
      "offset": offset,
      "total": total,
      "location": location,
      "order": order,
      "from": from,
      "to": to,
    };
  }

  factory OmiseCardModel.fromJson(Map<String, dynamic> json) {
    List<OmiseCard> data = [];
    json["data"].forEach((v) {
      data.add(OmiseCard.fromJson(v));
    });
    return OmiseCardModel(
      object: json["object"],
      data: data,
      limit: json["limit"],
      offset: json["offset"],
      total: json["total"],
      location: json["location"],
      order: json["order"],
      from: json["from"],
      to: json["to"],
    );
  }
}

// "object": "list",
// "data": [],
// "limit": 20,
// "offset": 0,
// "total": 0,
// "location": "/customers/cust_test_5n8f3o4j2c3zxwjo4n5/cards",
// "order": "chronological",
// "from": "1970-01-01T00:00:00Z",
// "to": "2021-03-19T17:58:49Z"