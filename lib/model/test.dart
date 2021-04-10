class Test {
  int _doctorId;
  List<DateList> _dateList;

  int get doctorId => _doctorId;
  List<DateList> get dateList => _dateList;

  Test({
      int doctorId, 
      List<DateList> dateList}){
    _doctorId = doctorId;
    _dateList = dateList;
}

  Test.fromJson(dynamic json) {
    _doctorId = json["doctorId"];
    if (json["dateList"] != null) {
      _dateList = [];
      json["dateList"].forEach((v) {
        _dateList.add(DateList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["doctorId"] = _doctorId;
    if (_dateList != null) {
      map["dateList"] = _dateList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2021-04-11"
/// foundDateFlag : "Y"

class DateList {
  String _date;
  String _foundDateFlag;

  String get date => _date;
  String get foundDateFlag => _foundDateFlag;

  DateList({
      String date, 
      String foundDateFlag}){
    _date = date;
    _foundDateFlag = foundDateFlag;
}

  DateList.fromJson(dynamic json) {
    _date = json["date"];
    _foundDateFlag = json["foundDateFlag"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = _date;
    map["foundDateFlag"] = _foundDateFlag;
    return map;
  }

}