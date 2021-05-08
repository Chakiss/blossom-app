import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';

class GenerateScbQrPromptPayUseCase extends BaseAsyncUseCase<Map<String, dynamic>, Map<String, dynamic>> {

  FirebaseFunctions _firebaseFunctions;

  GenerateScbQrPromptPayUseCase(this._firebaseFunctions);

  @override
  Future<Result<Map<String, dynamic>>> execute(Map<String, dynamic> parameter) async {
    try {
      HttpsCallable callable = _firebaseFunctions.httpsCallable("payments-scb-generatePromptPayQR");
      final result = await callable.call(parameter);
      return Success(Map<String, dynamic>.from(result.data));
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}