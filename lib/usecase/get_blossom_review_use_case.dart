import 'package:blossom_clinic/base/base_async_use_case.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/utils/error_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  class GetBlossomReviewUseCase extends BaseAsyncUseCase<dynamic, List<Map<String, String>>> {

  FirebaseFirestore _firestore;

  GetBlossomReviewUseCase(this._firestore);

  @override
  Future<Result<List<Map<String, String>>>> execute(parameter) async {
    try {
      final snapshot = await _firestore.collection("review").get();
      return Success(snapshot.docs.map((e) => Map<String, String>.from(e.data())).toList());
    } catch (e) {
      return Error(ErrorUtils.getErrorMessage(e));
    }
  }
}