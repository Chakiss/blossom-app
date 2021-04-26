import 'package:blossom_clinic/widget/history_segment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHistorySegmentControl extends StatefulWidget {

  Function(int) listener;

  DoctorHistorySegmentControl(this.listener);

  @override
  _DoctorHistorySegmentControlState createState() => _DoctorHistorySegmentControlState();
}

class _DoctorHistorySegmentControlState extends State<DoctorHistorySegmentControl> {

  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HistorySegmentItem(
            "การนัดหมาย",
            selectedPosition == 0,
            () {
              widget.listener.call(0);
              setState(() {
                selectedPosition = 0;
              });
            },
            width: 30 * MediaQuery.of(context).size.width / 100,
            radiusTopLeft: 6,
            radiusBottomLeft: 6,
          ),
          HistorySegmentItem(
            "ใบสั่งยา",
            selectedPosition == 1,
                () {
              widget.listener.call(1);
              setState(() {
                selectedPosition = 1;
              });
            },
            width: 30 * MediaQuery.of(context).size.width / 100,
            radiusTopRight: 6,
            radiusBottomRight: 6,
          )
        ],
      ),
    );
  }
}
