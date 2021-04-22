import 'package:blossom_clinic/model/time_slot_model.dart';

class AvailableSlotModel {
  DateTime createdAt;
  DateTime date;
  int slotType;
  List<TimeSlotModel> timeSlots;
  DateTime updatedAt;

  AvailableSlotModel({this.createdAt, this.date, this.slotType, this.timeSlots, this.updatedAt});
}