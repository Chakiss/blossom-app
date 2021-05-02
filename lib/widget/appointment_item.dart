import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/model/base/result.dart';
import 'package:blossom_clinic/usecase/get_user_reference_from_local_storage_use_case.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AppointmentItem extends StatefulWidget {
  AppointmentModel _appointmentModel;
  GetUserReferenceFromLocalStorageUseCase _getUserReferenceFromLocalStorageUseCase;

  AppointmentItem(this._appointmentModel, this._getUserReferenceFromLocalStorageUseCase);

  @override
  _AppointmentItemState createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  String name;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 60,
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
                    "${widget._appointmentModel.timeStart ?? ""}",
                    size: 14,
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.navigate_next, color: BlossomTheme.darkPink, size: 32,),
              )
            ],
          ),
          Container(
            height: 1,
            color: BlossomTheme.black,
            margin: EdgeInsets.symmetric(vertical: 10),
          )
        ],
      ),
    );
  }

  Future<void> getUserData() async {
    final result = await widget._getUserReferenceFromLocalStorageUseCase.execute(widget._appointmentModel.userReference);
    if (result is Success<String>) {
      setState(() {
        name = "${result.data ?? ""}";
      });
    }
  }
}
