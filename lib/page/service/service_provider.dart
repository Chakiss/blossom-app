import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/usecase/get_blossom_review_use_case.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends BaseProvider with ChangeNotifier {

  GetBlossomReviewUseCase _getBlossomReviewUseCase;

  ServiceProvider(this._getBlossomReviewUseCase);

  List<Map<String, String>> list;

  Future<void> callServiceGetReview() async {
    if (list == null) {
      final result = await _getBlossomReviewUseCase.execute(null);
      result.whenWithResult((data) {
        list = data;
        notifyListeners();
      }, (map) {

      });
    }
  }
}