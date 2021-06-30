import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GetAppointmentByUserIdUseCase extends BaseAsyncUseCase<String, Map<String, List<AppointmentModel>>> {
  FirebaseFirestore _firestore;

  GetAppointmentByUserIdUseCase(this._firestore);

  @override
  Future<Result<Map<String, List<AppointmentModel>>>> execute(String parameter) async {
    try {
      final snapshot = await _firestore
          .collection("appointments")
          .where("userReference", isEqualTo: _firestore.collection("patients").doc(parameter))
          .orderBy("timeStart", descending: true)
          .get();
      final rawList = snapshot.docs.map((e) => AppointmentModel.fromJson(e.id, e.data())).toList();
      Map<String, List<AppointmentModel>> map = {};
      final nowList = rawList
          .where((element) =>
      element.form?.post?.isCompleted == false &&
          DateFormat("yyyy-MM-dd")
              .parse(element.date)
              .difference(DateTime.now())
              .inDays >=
              0)
          .toList();
      final oldList = rawList
          .where((element) =>
      element.form?.post?.isCompleted == true ||
          DateFormat("yyyy-MM-dd")
              .parse(element.date)
              .difference(DateTime.now())
              .inDays <
              0)
          .toList();
      map["nowList"] = nowList;
      map["historyList"] = oldList;
      map["rawList"] = rawList;
      return Success(map);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
