import 'package:blossom_clinic/model/base/request_model.dart';

class CreateAppointmentOrderModel extends RequestModel {
  String doctorID;
  String userID;
  String availableSlotID;
  String timeSlotID;
  String slotID;

  CreateAppointmentOrderModel(this.doctorID, this.userID, this.availableSlotID, this.timeSlotID, this.slotID);

  @override
  Map<String, dynamic> toJson() {
    return {
      "doctorID": doctorID,
      "userID": userID,
      "availableSlotID": availableSlotID,
      "timeSlotID": timeSlotID,
      "slotID": slotID,
    };
  }
}
