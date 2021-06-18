import 'package:blossom_clinic/base/base_use_case.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';

class FilterAppointmentByTypeUseCase extends BaseUseCase<List<AppointmentModel>, Map<String, List<AppointmentModel>>> {
  @override
  Result<Map<String, List<AppointmentModel>>> execute(List<AppointmentModel> parameter) {
    Map<String, List<AppointmentModel>> map = {};
    final rawList = parameter;
    final nowList = rawList.where((element) => element.form?.post?.isCompleted == false).toList();
    final oldList = rawList.where((element) => element.form?.post?.isCompleted == true).toList();
    map["nowList"] = nowList;
    map["oldList"] = oldList;
    return Success(map);
  }
}