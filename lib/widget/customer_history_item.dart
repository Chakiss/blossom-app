import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_by_id_use_case.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blossom_theme.dart';
import 'blossom_circle_avatar.dart';

class CustomerHistoryItem extends StatefulWidget {
  AppointmentModel _appointmentModel;
  Function(AppointmentModel, String) _listener;
  DateFormat _dateFormat;
  DateFormat _dateFormatParse;
  DateFormat _timeFormat;
  DateFormat _timeFormatParse;
  GetDoctorProfileByIdUseCase _getDoctorProfileByIdUseCase;
  SharedPrefUtils _sharedPrefUtils;

  CustomerHistoryItem(this._appointmentModel, this._dateFormat, this._dateFormatParse, this._timeFormat,
      this._timeFormatParse, this._getDoctorProfileByIdUseCase, this._sharedPrefUtils, this._listener);

  @override
  _CustomerHistoryItemState createState() => _CustomerHistoryItemState();
}

class _CustomerHistoryItemState extends State<CustomerHistoryItem> {
  String doctorName;

  @override
  void initState() {
    if (widget._sharedPrefUtils.getMapDoctorReference().containsKey(widget._appointmentModel.doctorReference.id)) {
      doctorName = widget._sharedPrefUtils.getMapDoctorReference()[widget._appointmentModel.doctorReference.id];
    } else {
      _getDoctorNameByAnnotation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._listener.call(
          widget._appointmentModel,
          "${widget._timeFormatParse.format(widget._timeFormat.parse(widget._appointmentModel.timeStart))} น." +
              " - "
                  "${widget._timeFormatParse.format(widget._timeFormat.parse(widget._appointmentModel.timeEnd))} น.",
        );
      },
      child: Container(
        child: Column(
          children: [
            Container(
              width: 80 * MediaQuery.of(context).size.width / 100,
              child: Row(
                children: [
                  BlossomCircleAvatar(
                    30,
                    imageKey: widget._appointmentModel.doctorReference.id,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlossomText(
                          doctorName ?? "",
                          size: 14,
                        ),
                        BlossomText(
                          widget._dateFormatParse.format(widget._dateFormat.parse(widget._appointmentModel.date)),
                          size: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        BlossomText(
                            "${widget._timeFormatParse.format(widget._timeFormat.parse(widget._appointmentModel.timeStart))} น." +
                                " - "
                                    "${widget._timeFormatParse.format(widget._timeFormat.parse(widget._appointmentModel.timeEnd))} น.",
                            size: 12)
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.navigate_next,
                      color: BlossomTheme.darkPink,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
              height: 1,
              color: Color(0xFF8D8D8D),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getDoctorNameByAnnotation() async {
    final result = await widget._getDoctorProfileByIdUseCase.execute(widget._appointmentModel.doctorReference.id);
    if (result is Success<String>) {
      setState(() {
        doctorName = result.data;
      });
    }
  }
}
