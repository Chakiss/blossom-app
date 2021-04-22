import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/time_slot_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class DoctorDurationChoice extends StatefulWidget {

  List<TimeSlotModel> _timeSlots;
  Function(TimeSlotModel) listener;

  DoctorDurationChoice(this._timeSlots, {this.listener});

  @override
  _DoctorDurationChoiceState createState() => _DoctorDurationChoiceState();
}

class _DoctorDurationChoiceState extends State<DoctorDurationChoice> {

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _generateDurationChoice(),
      ),
    );
  }

  List<Widget> _generateDurationChoice() {
    List<Widget> choiceList = [];
    widget._timeSlots.asMap().forEach((key, value) {
      choiceList.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (selectedIndex != key) {
            _changeState(key);
          }
        },
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: selectedIndex == key ? BlossomTheme.pink : BlossomTheme.lightGray,
              size: 32,
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: BlossomText(
                  "${value.period} นาที",
                  size: 14,
                ))
          ],
        ),
      ));
    });
    return choiceList;
  }

  void _changeState(int index) {
    setState(() {
      selectedIndex = index;
      widget.listener.call(widget._timeSlots[index]);
    });
  }
}
