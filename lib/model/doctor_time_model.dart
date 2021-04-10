class DoctorTimeModel {

  String start;
  String end;
  String unit;

  DoctorTimeModel({this.start, this.end, this.unit});

  factory DoctorTimeModel.fromJson(Map<String, dynamic> json) {
    return DoctorTimeModel(
      start: json["start"],
      end: json["end"],
      unit: json["unit"]
    );
  }
}