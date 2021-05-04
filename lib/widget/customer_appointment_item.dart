import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/usecase/get_doctor_profile_by_id_use_case.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/widget/blossom_circle_avatar.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerAppointmentItem extends StatefulWidget {
  AppointmentModel _appointmentModel;
  Function(AppointmentModel) _listener;
  DateFormat _dateFormat;
  DateFormat _dateFormatParse;
  DateFormat _timeFormat;
  DateFormat _timeFormatParse;
  GetDoctorProfileByIdUseCase _getDoctorProfileByIdUseCase;
  SharedPrefUtils _sharedPrefUtils;

  CustomerAppointmentItem(this._appointmentModel, this._dateFormat, this._dateFormatParse, this._timeFormat,
      this._timeFormatParse, this._getDoctorProfileByIdUseCase, this._sharedPrefUtils, this._listener);

  @override
  _CustomerAppointmentItemState createState() => _CustomerAppointmentItemState();
}

class _CustomerAppointmentItemState extends State<CustomerAppointmentItem> {

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
    return Container(
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
                ButtonPinkGradient(
                  "โทร",
                  true,
                  () {
                    widget._listener.call(widget._appointmentModel);
                  },
                  radius: 6,
                  height: 32,
                  textSize: 13,
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
