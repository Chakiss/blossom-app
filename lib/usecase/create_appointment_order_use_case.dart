import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/create_appointment_order_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CreateAppointmentOrderUseCase extends BaseAsyncUseCase<CreateAppointmentOrderModel, dynamic> {

  FirebaseFunctions _firebaseFunctions;

  CreateAppointmentOrderUseCase(this._firebaseFunctions);

  @override
  Future<Result<dynamic>> execute(CreateAppointmentOrderModel parameter) async {
    try {
      print(parameter.toJson());
      HttpsCallable callable = _firebaseFunctions.httpsCallable("orders-createAppointmentOrder");
      final result = await callable.call(parameter.toJson());
      return Success(result.data);
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

}