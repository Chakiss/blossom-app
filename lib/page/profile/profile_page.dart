import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/page/add_customer_information/image_picker_dialog.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/blossom_profile_avatar.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:blossom_clinic/widget/text_stroke_pink.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
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
    _profileProvider.getProfileImage();
    return Consumer<ProfileProvider>(
      builder: (BuildContext context, ProfileProvider value, Widget child) {
        return Material(
          child: BaseScreen(
            child: Column(
              children: [
                ToolbarBack(title: "ข้อมูลส่วนตัว"),
                SizedBox(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              10 * MediaQuery.of(context).size.width / 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              onTap: () {
                                _showImagePickerDialog(context);
                              },
                              child: value.imagePath == null
                                  ? CircleAvatar(
                                      radius: 40 *
                                          MediaQuery.of(context).size.width /
                                          200,
                                      backgroundColor: BlossomTheme.white,
                                      backgroundImage: AssetImage(
                                          "assets/profile_place_holder.png"),
                                    )
                                  : BlossomProfileAvatar(
                                      40 *
                                          MediaQuery.of(context).size.width /
                                          200,
                                      imageUrl: value.imagePath,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                            "วัน/เดือน/ปีเกิด : ${_userData.userProfileModel?.birthDate == null ? "" : DateFormat("d MMMM yyyy", "TH").format(_userData.userProfileModel?.birthDate)}",
                            size: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          BlossomText(
                            "วันที่สมัคร : ${_userData.userProfileModel?.createdAt == null ? "" : DateFormat("d MMMM yyyy", "TH").format(_userData.userProfileModel?.createdAt)}",
                            size: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              10 * MediaQuery.of(context).size.width / 100),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextStrokePink("ประวัติการรักษา", () {
                              Navigator.push(
                                  context, RouteManager.routeCustomerHistory());
                            },
                                size: 20,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4)),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: TextStrokePink("ออกจากระบบ", () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialogTwoButton(
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
                                size: 20,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100),
                //   child: ButtonLoginFacebook(
                //     "Sync บัญชีกับ Facebook",
                //     true,
                //     () {
                //       _profileProvider.syncAccountWithFacebook(context);
                //     },
                //     radius: 6,
                //     height: 46,
                //   ),
                // ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10 * MediaQuery.of(context).size.width / 100),
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
                                    _launchURL(
                                        "https://www.facebook.com/blossomclinicth/");
                                  },
                                  child:
                                      Image.asset("assets/logo_facebook.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.instagram.com/blossomclinicth/");
                                  },
                                  child:
                                      Image.asset("assets/logo_instagram.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://twitter.com/blossomclinictw/");
                                  },
                                  child:
                                      Image.asset("assets/logo_twitter.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.youtube.com/channel/UCGt3gy6rRTNHXe-NSorvQ6Q/videos/");
                                  },
                                  child:
                                      Image.asset("assets/logo_youtube.png")),
                            ),
                          ),
                          Container(
                            width: 10 * MediaQuery.of(context).size.width / 100,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.blossomclinicthailand.com/");
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
        );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ImagePickerDialog((type) {
          Navigator.pop(context);
          if (type == 0) {
            _profileProvider.openGallery(context);
          } else {
            _profileProvider.openCamera(context);
          }
        });
      },
    );
  }
}
