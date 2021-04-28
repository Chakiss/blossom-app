import 'package:blossom_clinic/model/time_slot_model.dart';

class AvailableSlotModel {
  String id;
  DateTime createdAt;
  String date;
  int slotType;
  List<TimeSlotModel> timeSlots;
  DateTime updatedAt;

  AvailableSlotModel({this.id, this.createdAt, this.date, this.slotType, this.timeSlots, this.updatedAt});
}