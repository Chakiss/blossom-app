import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CreateAppointmentWithoutPaymentUseCase extends BaseAsyncUseCase<String, Map<dynamic, dynamic>> {
  FirebaseFunctions _firebaseFunctions;

  CreateAppointmentWithoutPaymentUseCase(this._firebaseFunctions);

  @override
  Future<Result<Map<dynamic, dynamic>>> execute(String parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("orders-createAppointmentWithoutPayment");
      final result = await callable.call({"orderID": parameter});
      return Success({});
    } catch (e) {
      print(e);
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
