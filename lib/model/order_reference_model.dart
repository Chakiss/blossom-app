class OrderReferenceModel {

  String availableSlotID;
  String slotID;
  String timeSlotID;


  OrderReferenceModel({this.availableSlotID, this.slotID, this.timeSlotID});

  factory OrderReferenceModel.fromJson(Map<String, dynamic> json) {
    return OrderReferenceModel(
      availableSlotID: json["availableSlotID"],
      slotID: json["slotID"],
      timeSlotID: json["timeSlotID"],
    );
  }
}