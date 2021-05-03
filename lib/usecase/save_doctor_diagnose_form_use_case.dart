import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/request/save_doctor_diagnose_request_model.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SaveDoctorDiagnoseFormUseCase extends BaseAsyncUseCase<SaveDoctorDiagnoseRequestModel, Map<dynamic, dynamic>> {

  FirebaseFunctions _firebaseFunctions;

  SaveDoctorDiagnoseFormUseCase(this._firebaseFunctions);

  @override
  Future<Result<Map<dynamic, dynamic>>> execute(SaveDoctorDiagnoseRequestModel parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("appointments-saveDoctorForm");
      final result = await callable.call(parameter.toJson());
      return Success(result.data);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}