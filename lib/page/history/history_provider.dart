import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/response/get_book_history_response_model.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends BaseProvider with ChangeNotifier {

  RemoteRepository _remoteRepository;
  UserModel _userModel;
  List<GetBookingHistoryResponseModel> bookingList;

  HistoryProvider(this._remoteRepository, this._userModel);

  Future<void> callServiceGetBookingHistory() async {
    if (_userModel.signInFacebookResponseModel != null) {
      bookingList = [];
      notifyListeners();
      final result = await _remoteRepository.getBookingHistory(_userModel.getBearerToken());
      result.whenWithResult((data) {
        bookingList = data.data;
        notifyListeners();
      }, (status) {

      });
    } else {

    }
  }

  Future<void> selectActive() async {

  }

  Future<void> selectHistory() async {

  }
}