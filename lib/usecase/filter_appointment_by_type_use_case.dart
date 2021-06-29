import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:intl/intl.dart';

class FilterAppointmentByTypeUseCase extends BaseUseCase<List<AppointmentModel>,
    Map<String, List<AppointmentModel>>> {
  @override
  Result<Map<String, List<AppointmentModel>>> execute(
      List<AppointmentModel> parameter) {
    Map<String, List<AppointmentModel>> map = {};
    final rawList = parameter;
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
    map["oldList"] = oldList;
    return Success(map);
  }
}
