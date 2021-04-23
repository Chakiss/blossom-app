import 'package:blossom_clinic/widget/history_segment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistorySegmentControl extends StatefulWidget {

  Function(int) listener;

  HistorySegmentControl(this.listener);

  @override
  _HistorySegmentControlState createState() => _HistorySegmentControlState();
}

class _HistorySegmentControlState extends State<HistorySegmentControl> {

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
            "การจ่ายเงิน",
            selectedPosition == 1,
            () {
              widget.listener.call(1);
              setState(() {
                selectedPosition = 1;
              });
            },
            width: 30 * MediaQuery.of(context).size.width / 100,
          ),
          HistorySegmentItem(
            "ใบสั่งยา",
            selectedPosition == 3,
                () {
              widget.listener.call(3);
              setState(() {
                selectedPosition = 3;
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
