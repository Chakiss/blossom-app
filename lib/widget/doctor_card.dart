import 'package:blossom_clinic/model/response/doctor_info.dart';
import 'package:flutter/material.dart';

import 'blossom_text.dart';

class DoctorCard extends StatelessWidget {

  DoctorInfo doctorInfo;
  Function() onTab;
  DoctorCard(this.doctorInfo, this.onTab);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTab,
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
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(doctorInfo.profileImg),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 18, right: 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlossomText(
                              doctorInfo?.profileTitle ?? "",
                              color: Color.fromRGBO(246, 107, 98, 1),
                              size: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            BlossomText(
                              "${doctorInfo?.firstName ?? ""} ${doctorInfo?.lastName ?? ""}",
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            BlossomText(
                              doctorInfo?.profileDesc ?? "",
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
