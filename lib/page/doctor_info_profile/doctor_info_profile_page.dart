import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/widget/blossom_circle_avatar.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';

import '../../blossom_theme.dart';

class DoctorInfoProfilePage extends StatelessWidget {
  DoctorInfoModel _doctorInfoModel;

  DoctorInfoProfilePage(this._doctorInfoModel);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      safeAreaBottom: false,
      child: Column(
        children: [
          ToolbarBack(
            title: _doctorInfoModel?.displayName ?? "",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: 80 * MediaQuery.of(context).size.width / 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        BlossomCircleAvatar(
                          60,
                          fileStorePath: _doctorInfoModel.displayPhoto,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlossomText(
                                  _doctorInfoModel?.displayName ?? "",
                                  color: BlossomTheme.darkPink,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                BlossomText(
                                    "${_doctorInfoModel?.firstName ?? ""}\n${_doctorInfoModel?.lastName ?? ""}",
                                    color: BlossomTheme.black,
                                    size: 17)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlossomText(
                      "ประวัติ",
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    BlossomText(
                      _doctorInfoModel.story,
                      size: 17,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
