import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/base_request_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/create_appointment_order_model.dart';
import 'package:blossom_clinic/model/response/create_appointment_order_response_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CreateAppointmentOrderUseCase extends BaseAsyncUseCase<BaseRequestModel<CreateAppointmentOrderModel>, CreateAppointmentOrderResponseModel> {

  FirebaseFunctions _firebaseFunctions;

  CreateAppointmentOrderUseCase(this._firebaseFunctions);

  @override
  Future<Result<CreateAppointmentOrderResponseModel>> execute(BaseRequestModel<CreateAppointmentOrderModel> parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("orders-createAppointmentOrder");
      final result = await callable.call(parameter.toJson());
      print(result.data);
      return Error({"message" : "test"});
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

}