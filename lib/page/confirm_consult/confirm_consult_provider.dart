import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/slot_model.dart';
import 'package:blossom_clinic/model/time_slot_model.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:flutter/material.dart';

class ConfirmConsultProvider extends BaseProvider with ChangeNotifier {

  int currentMinute;
  List<Widget> dateReserveList;
  TimeSlotModel timeSlotModel;
  SlotModel slotModel;
}
