import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/save_patient_form_request_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SavePatientFormUseCase extends BaseAsyncUseCase<SavePatientFormRequestModel, Map<dynamic, dynamic>> {

  FirebaseFunctions _firebaseFunctions;

  SavePatientFormUseCase(this._firebaseFunctions);

  @override
  Future<Result<Map<dynamic, dynamic>>> execute(SavePatientFormRequestModel parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("appointments-savePatientForm");
      final result = await callable.call(parameter.toJson());
      return Success(result.data);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}
