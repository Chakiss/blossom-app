import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class ConsultDoctorDayItem<T> extends StatefulWidget {
  String text;
  T data;
  int index;
  int selectedIndex;
  bool isEnable;
  Function(dynamic) onPressed;

  ConsultDoctorDayItem(this.text, this.data, this.isEnable, this.onPressed, {this.index, this.selectedIndex});

  @override
  _ConsultDoctorDayItemState<T> createState() => _ConsultDoctorDayItemState<T>();
}

class _ConsultDoctorDayItemState<T> extends State<ConsultDoctorDayItem<T>> {
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
            colors: widget.isEnable
                ? widget.index == widget.selectedIndex
                    ? [Color(0xFFEF567E), Color(0xFFE8A872)]
                    : [BlossomTheme.white, BlossomTheme.lightPink]
                : [BlossomTheme.white, BlossomTheme.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0), primary: Colors.transparent, elevation: 0, shadowColor: Colors.transparent),
        child: BlossomText(
          widget.text,
          size: 12,
          color: widget.isEnable
              ? widget.index == widget.selectedIndex
                  ? BlossomTheme.white
                  : BlossomTheme.black
              : BlossomTheme.black,
        ),
        onPressed: widget.isEnable ? () {
          widget.onPressed.call(widget.data);
        } : null,
      ),
    );
  }
}
