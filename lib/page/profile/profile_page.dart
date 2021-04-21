import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfileProvider _profileProvider;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of(context, listen: false);
    return BaseScreen(
      child: Column(
        children: [
          Toolbar(title: "ข้อมูลส่วนตัว"),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40 * MediaQuery.of(context).size.width / 200,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage("url"),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: BlossomText(
                      "name lastName",
                      size: 18,
                      fontWeight: FontWeight.bold,
                    )),
                Container(
                  child: ButtonPinkGradient(
                    "ออกจากระบบ",
                    true,
                    () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialogTwoButton(
                                title: "ออกจากระบบ",
                                description: "ยืนยันการออกจากระบบ",
                                positiveButton: "ตกลง",
                                positiveListener: () async {

                                },
                                negativeButton: "ยกเลิก",
                                negativeListener: () {
                                  Navigator.pop(context);
                                },
                              ));
                    },
                    width: 60 * MediaQuery.of(context).size.width / 100,
                    radius: 4,
                    textSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
