import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  ProfileProvider _profileProvider;
  UserData _userData = Injector.appInstance.get();

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of(context, listen: false);
    return BaseScreen(
      child: Column(
        children: [
          Toolbar(title: "ข้อมูลส่วนตัว"),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(context, RouteManager.routeAddCustomerInformation());
                            Navigator.push(context, RouteManager.routeDispense());
                          },
                          child: CircleAvatar(
                            radius: 40 * MediaQuery.of(context).size.width / 200,
                            backgroundColor: BlossomTheme.white,
                            backgroundImage: NetworkImage(
                                "https://lh3.googleusercontent.com/proxy/T8Z4qU1MzCNKKx0oUZyONA74RgwWPPmUOuaINHWQFiRq7EhaSwOTsVlcp5io-Ny3Scy_cYofCuUeL4cFN6QMVEl8N-tAHBebiLuT7VyWRvmHqGFAE4f7HAb7Kgf3pZqGy7nLEs0zEA"),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "${_userData.userProfileModel?.firstName} ${_userData.userProfileModel?.lastName}",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlossomText(
                        "เบอร์โทร : ${_userData.userProfileModel?.phoneNumber?.replaceAll("+66", "0")}",
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      BlossomText(
                        "email : ${_userData.userProfileModel?.email}",
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      BlossomText(
                        "วัน/เดือน/ปีเกิด : ${DateFormat("d MMMM yyyy", "TH").format(_userData.userProfileModel?.birthDate)}",
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      BlossomText(
                        "วันที่สมัคร : ${DateFormat("d MMMM yyyy", "TH").format(_userData.userProfileModel?.createdAt)}",
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24,),
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
                                positiveListener: () {
                                  _profileProvider.logout(context);
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
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "ข้อมูล Blossom",
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL("https://www.facebook.com/blossomclinicth/");
                                  },
                                  child: Image.asset("assets/logo_facebook.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL("https://www.instagram.com/blossomclinicth/");
                                  },
                                  child: Image.asset("assets/logo_instagram.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL("https://twitter.com/blossomclinictw/");
                                  },
                                  child: Image.asset("assets/logo_twitter.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL("https://www.youtube.com/channel/UCGt3gy6rRTNHXe-NSorvQ6Q/videos/");
                                  },
                                  child: Image.asset("assets/logo_youtube.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL("https://www.blossomclinicthailand.com/");
                                  },
                                  child: Image.asset("assets/logo_web.png")),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
