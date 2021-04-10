class DateReserveModel {

  String date;
  String foundDateFlag;

  DateReserveModel({this.date, this.foundDateFlag});

  factory DateReserveModel.fromJson(Map<String, dynamic> json) {
    return DateReserveModel(
      date: json["date"],
      foundDateFlag: json["foundDateFlag"]
    );
  }
}