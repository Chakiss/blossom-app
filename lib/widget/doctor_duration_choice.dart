import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/response/get_doctor_min_consult_response_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class DoctorDurationChoice extends StatefulWidget {

  List<GetDoctorMinConsultResponseModel> list;
  Function(int) listener;

  DoctorDurationChoice({this.listener, this.list});

  @override
  _DoctorDurationChoiceState createState() => _DoctorDurationChoiceState();
}

class _DoctorDurationChoiceState extends State<DoctorDurationChoice> {

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.listener.call(widget.list[0].quota);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _generateDurationChoice(widget.list),
      ),
    );
  }

  List<Widget> _generateDurationChoice(List<GetDoctorMinConsultResponseModel> list) {
    List<Widget> choiceList = [];
    list.asMap().forEach((key, value) {
      choiceList.add(
          GestureDetector(
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
                Container(margin: EdgeInsets.only(left: 10), child: BlossomText("${value.quota} นาที", size: 14,))
              ],
            ),
          )
      );
    });
    return choiceList;
  }

  void _changeState(int index) {
    setState(() {
      selectedIndex = index;
      widget.listener.call(widget.list[index].quota);
    });
  }
}
