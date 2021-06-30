import 'package:blossom_clinic/widget/segment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistorySegmentControl extends StatefulWidget {

  Function(int) listener;
  int selectedPosition;

  HistorySegmentControl(this.listener,{this.selectedPosition = 0});

  @override
  _HistorySegmentControlState createState() => _HistorySegmentControlState();
}

class _HistorySegmentControlState extends State<HistorySegmentControl> {

  int selectedPosition;

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.selectedPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentItem(
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
          SegmentItem(
            "ประวัติ",
            selectedPosition == 1,
                () {
              widget.listener.call(1);
              setState(() {
                selectedPosition = 1;
              });
            },
            width: 30 * MediaQuery.of(context).size.width / 100,
          ),
          SegmentItem(
            "ใบสั่งยา",
            selectedPosition == 2,
                () {
              widget.listener.call(2);
              setState(() {
                selectedPosition = 2;
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
