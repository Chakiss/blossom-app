
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/widget/blossom_circle_avatar.dart';
import 'package:flutter/material.dart';

import 'blossom_text.dart';

class DoctorCard extends StatefulWidget {

  DoctorInfoModel doctorInfo;
  Function() onTab;
  DoctorCard(this.doctorInfo, this.onTab);

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTab,
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          elevation: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlossomCircleAvatar(widget.doctorInfo.displayPhoto, 40),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 18, right: 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlossomText(
                              widget.doctorInfo?.displayName ?? "",
                              color: Color.fromRGBO(246, 107, 98, 1),
                              size: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            BlossomText(
                              "${widget.doctorInfo?.firstName ?? ""} ${widget.doctorInfo?.lastName ?? ""}",
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            BlossomText(
                              widget.doctorInfo?.story ?? "",
                              maxLines: 3,
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 25),
                    child: Icon(Icons.navigate_next)),
              )
            ],
          )
        ),
      ),
    );
  }
}
