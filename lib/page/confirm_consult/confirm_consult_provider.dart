import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/date_reserve_model.dart';
import 'package:blossom_clinic/model/doctor_time_model.dart';
import 'package:blossom_clinic/model/omise_card.dart';
import 'package:blossom_clinic/model/request/booking_consult_doctor_request_model.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/model/response/get_doctor_min_consult_response_model.dart';
import 'package:blossom_clinic/model/response/omise_add_customer_response_model.dart';
import 'package:blossom_clinic/page/webview/web_view_page.dart';
import 'package:blossom_clinic/repository/omise_repository.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class ConfirmConsultProvider extends BaseProvider with ChangeNotifier {
  OmiseRepository _omiseRepository;

  ConfirmConsultProvider(this._omiseRepository);

  DoctorDurationChoice doctorDurationChoice;
  GetDoctorMinConsultResponseModel doctorMin;
  int currentMinute;
  List<Widget> dateReserveList;
  DoctorTimeModel doctorTimeModel;
  var selectedIndex = -1;

  Future<void> callServiceGetDoctorMinConsult(BuildContext context, int doctorId, String dateTime) async {
    final result = await remoteRepository.getDoctorMinConsult();
    result.whenWithResult((data) {
      if (data?.data != null) {
        doctorDurationChoice = DoctorDurationChoice(
            list: data?.data,
            listener: (value) {
              doctorMin = value;
              doctorTimeModel = null;
              currentMinute = value.quota;
              callServiceGetDoctorTimeReserve(context, doctorId.toString(), dateTime, currentMinute);
            });
        notifyListeners();
      }
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }

  Future<void> callServiceGetDoctorTimeReserve(BuildContext context, String doctorId, String date, int minute) async {
    selectedIndex = -1;
    final result = await remoteRepository.getDoctorTimeReserve(doctorId, date, minute);
    result.whenWithResult((data) {
      dateReserveList = _generateTimeReserveItem(data.data.timeList);
      notifyListeners();
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }

  List<Widget> _generateTimeReserveItem(List<DoctorTimeModel> timeReserveListData) {
    List<Widget> list = [];
    timeReserveListData.asMap().forEach((index, element) {
      list.add(ConsultDoctorDayItem<DoctorTimeModel>(
        "${element?.start ?? ""} ${element?.unit ?? "น."}",
        element,
        true,
        (timeReserve) {
          print("Test Item Click $index");
          selectedIndex = index;
          dateReserveList = _generateTimeReserveItem(timeReserveListData);
          doctorTimeModel = timeReserve;
          notifyListeners();
        },
        index: index,
        selectedIndex: selectedIndex,
      ));
    });
    return list;
  }

  Future<void> confirmConsult(BuildContext context, DoctorInfo doctorInfo, GetDoctorMinConsultResponseModel doctorMin,
      DoctorTimeModel doctorTimeModel, DateReserveModel dateReserveModel) async {
    final AccessToken accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      await _callServiceBookingConsultDoctor(context, doctorMin.packCode, doctorInfo.doctorId,
          "${dateReserveModel.date} ${doctorTimeModel.start}", "${dateReserveModel.date} ${doctorTimeModel.end}");
    } else {

    }
  }

  Future<OmiseCard> checkHaveCreditCard() async {
    final result =
        await _omiseRepository.getCustomer(userModel.getBasicToken(), userModel.profileResponseModel.omiseCustId);
    if (result is Success<OmiseAddCustomerResponseModel>) {
      if (result.data?.cards?.data?.isNotEmpty == true) {
        return result.data?.cards?.data?.first;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> _callServiceBookingConsultDoctor(
      BuildContext context, int packCode, int doctorId, String startDate, String endDate) async {
    BookingConsultDoctorRequestModel requestModel =
        BookingConsultDoctorRequestModel(packCode, doctorId, startDate, endDate);
    final result = await remoteRepository.bookingConsultDoctor(userModel.getBearerToken(), requestModel);
    result.whenWithResult((data) {
      openWebViewUrl(context, "Omise", data.data.omiseChargeAuthUrl);
    }, (statusModel) {
      errorHandle.proceed(context, statusModel);
    });
  }

  void openWebViewUrl(BuildContext context, String title, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
    {
      return WebViewPage(title, url ?? "https://www.google.co.th");
    }));
  }
}
