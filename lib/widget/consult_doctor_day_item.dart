import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ConsultDoctorDayItem extends StatefulWidget {
  AvailableSlotModel _data;
  String _title;
  DateTime selectedDate;
  Function(AvailableSlotModel) _onPressed;

  ConsultDoctorDayItem(this._data, this._title, this._onPressed, {this.selectedDate});

  @override
  _ConsultDoctorDayItemState createState() => _ConsultDoctorDayItemState();
}

class _ConsultDoctorDayItemState extends State<ConsultDoctorDayItem> {
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
            colors: widget.selectedDate == widget._data.date
                ? [Color(0xFFEF567E), Color(0xFFE8A872)]
                : [BlossomTheme.white, BlossomTheme.lightPink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0), primary: Colors.transparent, elevation: 0, shadowColor: Colors.transparent),
        child: BlossomText(widget._title, size: 12, color:
        widget.selectedDate == widget._data.date ? BlossomTheme.white : BlossomTheme.black),
        onPressed: () {
          widget._onPressed.call(widget._data);
        },
      ),
    );
  }
}
