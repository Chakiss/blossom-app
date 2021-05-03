import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/widget/blossom_circle_avatar.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerAppointmentItem extends StatelessWidget {
  AppointmentModel _appointmentModel;
  Function(AppointmentModel) _listener;
  DateFormat _dateFormat;
  DateFormat _dateFormatParse;
  DateFormat _timeFormat;
  DateFormat _timeFormatParse;

  CustomerAppointmentItem(this._appointmentModel, this._dateFormat, this._dateFormatParse, this._timeFormat,
      this._timeFormatParse, this._listener);

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
                  imageKey: _appointmentModel.doctorReference.id,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlossomText(
                        _dateFormatParse.format(_dateFormat.parse(_appointmentModel.date)),
                        size: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      BlossomText(
                          "${_timeFormatParse.format(_timeFormat.parse(_appointmentModel.timeStart))} น." +
                          " - "
                          "${_timeFormatParse.format(_timeFormat.parse(_appointmentModel.timeEnd))} น.",
                          size: 12)
                    ],
                  ),
                )),
                ButtonPinkGradient(
                  "โทร",
                  true,
                  () {
                    _listener.call(_appointmentModel);
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
}
