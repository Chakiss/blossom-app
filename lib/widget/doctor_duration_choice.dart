import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class DoctorDurationChoice extends StatefulWidget {
  Function(String) listener;

  DoctorDurationChoice({this.listener});

  @override
  _DoctorDurationChoiceState createState() => _DoctorDurationChoiceState();
}

class _DoctorDurationChoiceState extends State<DoctorDurationChoice> {

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.listener.call("5 นาที");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _changeState(0);
            },
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: selectedIndex == 0 ? BlossomTheme.pink : BlossomTheme.lightGray,
                  size: 32,
                ),
                Container(margin: EdgeInsets.only(left: 10), child: BlossomText("5 นาที"))
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _changeState(1);
            },
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: selectedIndex == 1 ? BlossomTheme.pink : BlossomTheme.lightGray,
                  size: 32,
                ),
                Container(margin: EdgeInsets.only(left: 10), child: BlossomText("15 นาที"))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _changeState(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        widget.listener.call("5 นาที");
      } else {
        widget.listener.call("15 นาที");
      }
    });
  }
}
