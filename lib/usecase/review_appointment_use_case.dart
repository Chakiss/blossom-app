import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class ReviewAppointmentUseCase extends BaseAsyncUseCase<Map<String, dynamic>, Map<dynamic, dynamic>> {

  FirebaseFunctions _firebaseFunctions;

  ReviewAppointmentUseCase(this._firebaseFunctions);

  @override
  Future<Result<Map>> execute(Map<String, dynamic> parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("reviews-reviewAppointment");
      final result = await callable.call(parameter);
      return Success(Map<dynamic, dynamic>.from(result.data));
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}