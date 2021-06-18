import 'package:blossom_clinic/widget/segment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHistorySegmentControl extends StatefulWidget {

  Function(int) listener;
  int selectedPosition;

  DoctorHistorySegmentControl(this.listener, {this.selectedPosition = 0});

  @override
  _DoctorHistorySegmentControlState createState() => _DoctorHistorySegmentControlState();
}

class _DoctorHistorySegmentControlState extends State<DoctorHistorySegmentControl> {

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
            "ตารางนัดหมาย",
            selectedPosition == 0,
            () {
              widget.listener.call(0);
              setState(() {
                selectedPosition = 0;
              });
            },
            width: 40 * MediaQuery.of(context).size.width / 100,
            radiusTopLeft: 6,
            radiusBottomLeft: 6,
          ),
          SegmentItem(
            "ประวัตินัดหมาย",
            selectedPosition == 1,
                () {
              widget.listener.call(1);
              setState(() {
                selectedPosition = 1;
              });
            },
            width: 40 * MediaQuery.of(context).size.width / 100,
            radiusTopRight: 6,
            radiusBottomRight: 6,
          )
        ],
      ),
    );
  }
}
