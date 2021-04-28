import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/slot_model.dart';
import 'package:blossom_clinic/model/time_slot_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetDoctorAvailableSlotsUseCase extends BaseAsyncUseCase<String, List<AvailableSlotModel>> {
  FirebaseFirestore _firestore;

  GetDoctorAvailableSlotsUseCase(this._firestore);

  @override
  Future<Result<List<AvailableSlotModel>>> execute(String parameter) async {
    try {
      final snapshot = await _firestore
          .collection("doctors")
          .doc(parameter)
          .collection("availableSlots")
          .where("slotType", isEqualTo: 1)
          .orderBy("date")
          .get();
      final list = snapshot.docs
          .map((e) => AvailableSlotModel(
              id: e.id,
              createdAt: e.data()["createdAt"].toDate(),
              date: e.data()["date"],
              slotType: e.data()["slotType"],
              timeSlots: _getTimeSlotFromMap(e.data()["timeSlots"].toList()),
              updatedAt: e.data()["updatedAt"].toDate()))
          .toList();
      return Success(list);
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

  List<TimeSlotModel> _getTimeSlotFromMap(List<dynamic> data) {
    List<TimeSlotModel> list = [];
    data.forEach((timeSlot) {
      list.add(TimeSlotModel(
          id: timeSlot["id"],
          period: timeSlot["period"],
          priceCost: timeSlot["priceCost"],
          priceSale: timeSlot["priceSale"],
          slots: _getSlotFromMap(timeSlot["slots"].toList())));
    });
    return list;
  }

  List<SlotModel> _getSlotFromMap(List<dynamic> data) {
    List<SlotModel> list = [];
    data.forEach((slot) {
      list.add(SlotModel(
          id: slot["id"],
          isAvailable: slot["isAvailable"],
          timeEnd: slot["timeEnd"],
          timeStart: slot["timeStart"],
          title: slot["title"]));
    });
    return list;
  }
}
