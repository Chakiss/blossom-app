import 'package:blossom_clinic/page/customer_treat_history/customer_treat_history_provider.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_by_id_use_case.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/customer_history_item.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class CustomerTreatHistoryPage extends StatelessWidget {
  CustomerTreatHistoryProvider _provider;
  DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat _dateFormatParse = DateFormat("d MMMM yyyy", "TH");
  DateFormat _timeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat _timeFormatParse = DateFormat("HH:mm");
  GetDoctorProfileByIdUseCase _getDoctorProfileByIdUseCase = Injector.appInstance.get();
  SharedPrefUtils _sharedPrefUtils = Injector.appInstance.get();
  UserData _userData = Injector.appInstance.get();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.callServiceGetAppointmentList();
    return Scaffold(
      backgroundColor: BlossomTheme.darkPink,
      body: Column(
        children: [
          Stack(
            children: [
              SafeArea(
                child: ToolbarBack(
                  title: "ประวัติการรักษา",
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: BlossomTheme.white,
              child: Consumer<CustomerTreatHistoryProvider>(
                builder: (BuildContext context, CustomerTreatHistoryProvider value, Widget child) {
                  if (value.list == null) {
                    return Container(
                        child: Center(
                      child: BlossomProgressIndicator(),
                    ));
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: value.list?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CustomerHistoryItem(
                                  value.list[index],
                                  _dateFormat,
                                  _dateFormatParse,
                                  _timeFormat,
                                  _timeFormatParse,
                                  _getDoctorProfileByIdUseCase,
                                  _sharedPrefUtils, (appointment, appointmentTime) {
                                Navigator.push(
                                    context,
                                    RouteManager.routeCustomerHistoryDetail(
                                        appointment,
                                        "${_userData.userProfileModel.firstName} ${_userData.userProfileModel.lastName}",
                                        appointmentTime));
                              }),
                            ],
                          );
                        } else {
                          return CustomerHistoryItem(
                              value.list[index],
                              _dateFormat,
                              _dateFormatParse,
                              _timeFormat,
                              _timeFormatParse,
                              _getDoctorProfileByIdUseCase,
                              _sharedPrefUtils, (appointment, appointmentTime) {
                            Navigator.push(
                                context,
                                RouteManager.routeCustomerHistoryDetail(
                                    appointment,
                                    "${_userData.userProfileModel.firstName} ${_userData.userProfileModel.lastName}",
                                    appointmentTime));
                          });
                        }
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
