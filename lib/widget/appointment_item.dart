import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AppointmentItem extends StatefulWidget {
  AppointmentModel _appointmentModel;

  AppointmentItem(this._appointmentModel);

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
                    size: 16,
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
    final userReference = await widget._appointmentModel.userReference.get();
    setState(() {
      name = "${userReference.data()["firstName"] ?? ""} ${userReference.data()["lastName"] ?? ""}";
    });
  }
}
