import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/usecase/set_user_reference_to_local_storage_use_case.dart';
import 'package:blossom_clinic/utils/shared_pref_utils.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentItem extends StatefulWidget {
  AppointmentModel _appointmentModel;
  SharedPrefUtils _sharedPrefUtils;
  SetUserReferenceToLocalStorageUseCase _setUserReferenceFromLocalStorageUseCase;
  Function(AppointmentModel, String, String) _listener;
  DateFormat dateFormat;
  DateFormat dateFormatParse;

  AppointmentItem(
      this._appointmentModel, this._sharedPrefUtils, this._setUserReferenceFromLocalStorageUseCase, this._listener,
      {this.dateFormat, this.dateFormatParse});

  @override
  _AppointmentItemState createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  String name;
  String appointmentTime;

  @override
  void initState() {
    super.initState();
    getUserData();
    appointmentTime = widget.dateFormatParse.format(widget.dateFormat.parse(widget._appointmentModel.timeStart));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._listener.call(widget._appointmentModel, name, appointmentTime);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: BlossomTheme.white,
                  backgroundImage: AssetImage("assets/profile_place_holder.png"),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlossomText(
                      "${name ?? ""}",
                      size: 18,
                    ),
                    BlossomText(
                      appointmentTime,
                      size: 14,
                    )
                  ],
                ),
                Spacer(),
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
            Container(
              height: 1,
              color: BlossomTheme.black,
              margin: EdgeInsets.only(top: 16),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getUserData() async {
    if (widget._sharedPrefUtils.getMapUserReference().containsKey(widget._appointmentModel.userReference.path)) {
      setState(() {
        name = widget._sharedPrefUtils.getMapUserReference()[widget._appointmentModel.userReference.path];
      });
    } else {
      final result =
          await widget._setUserReferenceFromLocalStorageUseCase.execute(widget._appointmentModel.userReference);
      if (result is Success<String>) {
        setState(() {
          name = "${result.data ?? ""}";
        });
      }
    }
  }
}
