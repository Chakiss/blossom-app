import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/model/slot_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultDoctorTimeItem extends StatefulWidget {
  SlotModel _data;
  String selectedTime;
  Function(SlotModel) _onPressed;

  ConsultDoctorTimeItem(this._data, this._onPressed, {this.selectedTime});

  @override
  _ConsultDoctorTimeItemState createState() => _ConsultDoctorTimeItemState();
}

class _ConsultDoctorTimeItemState extends State<ConsultDoctorTimeItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          gradient: LinearGradient(
            colors: widget.selectedTime == widget._data.title
                ? [Color(0xFFEF567E), Color(0xFFE8A872)]
                : [BlossomTheme.white, BlossomTheme.lightPink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0), primary: Colors.transparent, elevation: 0, shadowColor: Colors.transparent),
        child: BlossomText(widget._data.title,
            size: 12, color: widget.selectedTime == widget._data.title ? BlossomTheme.white : BlossomTheme.black),
        onPressed: widget._data.isAvailable &&
                DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget._data.timeStart).isAfter(DateTime.now())
            ? () {
                widget._onPressed.call(widget._data);
              }
            : null,
      ),
    );
  }
}
