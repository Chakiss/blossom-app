import 'package:blossom_clinic/model/slot_model.dart';

class TimeSlotModel {

  String id;
  int period;
  int priceCost;
  int priceSale;
  List<SlotModel> slots;

  TimeSlotModel({this.id, this.period, this.priceCost, this.priceSale, this.slots});
}