import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/customer_home_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blossom_theme.dart';

class CustomerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.white,
      body: Column(
        children: [
          Stack(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 100 * MediaQuery.of(context).size.width / 100,
                child: Image.asset("assets/nav_bar.png"),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, RouteManager.routeProfile());
                      },
                      child: SvgPicture.asset(
                        "assets/ic_new_user.svg",
                        width: 42,
                        height: 42,
                      ),
                    ),
                    Spacer(),
                    // Image.asset(
                    //   "assets/profile_place_holder.png",
                    //   width: 46,
                    //   height: 46,
                    // )
                  ],
                ),
              ),
            )
          ]),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 5 * MediaQuery.of(context).size.width / 100,
                  vertical: 2 * MediaQuery.of(context).size.height / 100),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.2 / 1,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: CustomerHomeBanner(),
                      elevation: 6,
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, RouteManager.routeHistory());
                        },
                        child: Container(
                            width: 25 * MediaQuery.of(context).size.width / 100,
                            height: 30 * MediaQuery.of(context).size.width / 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                gradient: LinearGradient(
                                  colors: [Color(0xFFED6283), Color(0xFFEA827E)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/ic_new_calendar.svg"),
                                SizedBox(
                                  height: 6,
                                ),
                                BlossomText(
                                  "ตารางนัดหมาย",
                                  size: 14,
                                  color: BlossomTheme.white,
                                )
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, RouteManager.routeCustomerHistory());
                        },
                        child: Container(
                            width: 25 * MediaQuery.of(context).size.width / 100,
                            height: 30 * MediaQuery.of(context).size.width / 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                gradient: LinearGradient(
                                  colors: [Color(0xFFED6283), Color(0xFFEA827E)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/ic_new_history.svg"),
                                SizedBox(
                                  height: 6,
                                ),
                                BlossomText(
                                  "ประวัติการรักษา",
                                  size: 14,
                                  color: BlossomTheme.white,
                                )
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, RouteManager.routeProfile());
                        },
                        child: Container(
                            width: 25 * MediaQuery.of(context).size.width / 100,
                            height: 30 * MediaQuery.of(context).size.width / 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                gradient: LinearGradient(
                                  colors: [Color(0xFFED6283), Color(0xFFEA827E)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/ic_new_member.svg"),
                                SizedBox(
                                  height: 6,
                                ),
                                BlossomText(
                                  "สมาชิก",
                                  size: 14,
                                  color: BlossomTheme.white,
                                )
                              ],
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
    ;
  }
}
