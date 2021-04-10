import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/profile/profile_provider.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {

  ProfileProvider _profileProvider;

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of(context, listen: false);
    return BaseScreen(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset("assets/splashscreen.svg"),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: ButtonPinkGradient(
                "ออกจากระบบ",
                true, () async {
                  _profileProvider.logout(context);
                },
                width: 60 * MediaQuery.of(context).size.width / 100,
                radius: 4,
                textSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
