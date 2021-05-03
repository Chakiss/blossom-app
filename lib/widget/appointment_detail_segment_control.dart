import 'package:blossom_clinic/widget/segment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentDetailSegmentControl extends StatefulWidget {

  Function(int) listener;

  AppointmentDetailSegmentControl(this.listener);

  @override
  _AppointmentDetailSegmentControlState createState() => _AppointmentDetailSegmentControlState();
}

class _AppointmentDetailSegmentControlState extends State<AppointmentDetailSegmentControl> {

  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentItem(
            "ข้อมูล",
            selectedPosition == 0,
            () {
              if (selectedPosition != 0) {
                widget.listener.call(0);
                setState(() {
                  selectedPosition = 0;
                });
              }
            },
            width: 30 * MediaQuery.of(context).size.width / 100,
            radiusTopLeft: 6,
            radiusBottomLeft: 6,
          ),
          SegmentItem(
            "คำวินิจฉัย",
            selectedPosition == 1,
            () {
              if (selectedPosition != 1) {
                widget.listener.call(1);
                setState(() {
                  selectedPosition = 1;
                });
              }
            },
            width: 30 * MediaQuery.of(context).size.width / 100,
          ),
          SegmentItem(
            "ยาที่สั่ง",
            selectedPosition == 2,
                () {
              if (selectedPosition != 2) {
                widget.listener.call(2);
                setState(() {
                  selectedPosition = 2;
                });
              }
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
