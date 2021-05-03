import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class UpdateShipnityReferenceUseCase extends BaseAsyncUseCase<Map<String, dynamic>, Map<dynamic, dynamic>> {

  FirebaseFunctions _firebaseFunctions;

  UpdateShipnityReferenceUseCase(this._firebaseFunctions);

  @override
  Future<Result<Map>> execute(Map<String, dynamic> parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("appointments-updateShipnityReference");
      final result = await callable.call(parameter);
      return Success(result.data);
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }

}