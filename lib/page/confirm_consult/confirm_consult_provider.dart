import 'package:blossom_clinic/base/base_provider.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/model/base_model.dart';
import 'package:blossom_clinic/model/date_reserve_model.dart';
import 'package:blossom_clinic/model/doctor_time_model.dart';
import 'package:blossom_clinic/model/request/booking_consult_doctor_request_model.dart';
import 'package:blossom_clinic/model/response/booking_consult_doctor_response_model.dart';
import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:blossom_clinic/model/response/get_doctor_min_consult_response_model.dart';
import 'package:blossom_clinic/model/user_model.dart';
import 'package:blossom_clinic/page/add_card/add_card_page.dart';
import 'package:blossom_clinic/page/add_card/add_card_provider.dart';
import 'package:blossom_clinic/page/webview/web_view_page.dart';
import 'package:blossom_clinic/repository/remote_repository.dart';
import 'package:blossom_clinic/usecase/login_facebook_use_case.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class ConfirmConsultProvider extends BaseProvider with ChangeNotifier {

  UserModel _userModel;
  RemoteRepository _remoteRepository;
  LoginFacebookUseCase _loginUseCase;

  ConfirmConsultProvider(this._userModel, this._remoteRepository, this._loginUseCase);

  DoctorDurationChoice doctorDurationChoice;
  GetDoctorMinConsultResponseModel doctorMin;
  int currentMinute;
  List<Widget> dateReserveList;
  DoctorTimeModel doctorTimeModel;
  var selectedIndex = -1;

  Future<void> callServiceGetDoctorMinConsult(BuildContext context, int doctorId, String dateTime) async {
    final result = await _remoteRepository.getDoctorMinConsult();
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
    final result = await _remoteRepository.getDoctorTimeReserve(doctorId, date, minute);
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
    if (_userModel.signInResponseModel != null) {
      final result = await _callServiceBookingConsultDoctor(context, doctorMin.packCode, doctorInfo.doctorId,
          "${dateReserveModel.date} ${doctorTimeModel.start}", "${dateReserveModel.date} ${doctorTimeModel.end}");
      result.whenWithResult((data) {
        openWebViewUrl(context, "Omise", data.data.omiseChargeAuthUrl);
      }, (statusModel) async {
        if (statusModel.resCode == "1004") {
          _showDialogAddCard(context);
        } else {
          errorHandle.proceed(context, statusModel);
        }
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext dialogContext) => CustomDialogTwoButton(
              title: "คุณยังไม่ได้เข้าสู่ระบบ",
              description: "กรุณาเข้าสู่ระบบเพื่อทำการจอง",
              positiveButton: "เข้าสู่ระบบ",
              positiveListener: () async {
                await loginFacebook(dialogContext, doctorInfo, doctorMin, doctorTimeModel, dateReserveModel);
              },
              negativeButton: "ยกเลิก",
              negativeListener: () async {
                Navigator.pop(dialogContext);
              }));
    }
  }

  void _showDialogAddCard(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) => CustomDialogTwoButton(
            title: "คุณไม่มีช่องทางการเงิน",
            description: "กรุณาเพิ่มบัตรเครดิต/เดบิต เพื่อทำรายการ",
            positiveButton: "เพิ่มบัตร",
            positiveListener: () async {
              Navigator.pop(dialogContext);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return MultiProvider(providers: [
                  ChangeNotifierProvider(create: (BuildContext context) => AddCardProvider(
                    Injector.appInstance.get(),
                    Injector.appInstance.get(),
                  ),)
                ],
                child: AddCardPage(),);
              }));
            },
            negativeButton: "ยกเลิก",
            negativeListener: () async {
              Navigator.pop(dialogContext);
            }));
  }

  // Future<OmiseCard> checkHaveCreditCard() async {
  //   final result =
  //       await _omiseRepository.getCustomer(userModel.getBasicToken(), _userModel.profileResponseModel.omiseCustId);
  //   if (result is Success<OmiseAddCustomerResponseModel>) {
  //     if (result.data?.cards?.data?.isNotEmpty == true) {
  //       return result.data?.cards?.data?.first;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  Future<Result<BaseModel<BookingConsultDoctorResponseModel>>> _callServiceBookingConsultDoctor(
      BuildContext context, int packCode, int doctorId, String startDate, String endDate) async {
    BookingConsultDoctorRequestModel requestModel =
        BookingConsultDoctorRequestModel(packCode, doctorId, startDate, endDate);
    final result = await _remoteRepository.bookingConsultDoctor(_userModel.getBearerToken(), requestModel);
    return result;
  }

  void openWebViewUrl(BuildContext context, String title, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return WebViewPage(title, url ?? "https://www.google.co.th");
    }));
  }

  Future<void> loginFacebook(BuildContext context, DoctorInfo doctorInfo, GetDoctorMinConsultResponseModel doctorMin,
      DoctorTimeModel doctorTimeModel, DateReserveModel dateReserveModel) async {
    final LoginResult result = await FacebookAuth.instance
        .login(loginBehavior: LoginBehavior.WEB_VIEW_ONLY); // by the fault we request the email and the public profile
    if (result.status == LoginStatus.success) {
      final loginResult = await _loginUseCase.execute(context, FacebookAuth.instance);
      loginResult.whenWithResult((data) async {
        await showToast("เข้าสู่ระบบสำเร็จ กรุณากดทำรายการอีกครั้ง");
        Navigator.pop(context);
      }, (statusModel) {
        errorHandle.proceed(context, statusModel);
      });
    } else {}
  }
}
