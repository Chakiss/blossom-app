import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/page/doctor_diagnose/doctor_diagnose_page.dart';
import 'package:blossom_clinic/page/doctor_diagnose/doctor_diagnose_provider.dart';
import 'package:blossom_clinic/page/doctor_home/doctor_home_provider.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/blossom_circle_avatar.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class DoctorHomePage extends StatelessWidget {
  DoctorHomeProvider _provider;
  UserData _userData = Injector.appInstance.get();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    return BaseScreen(
      child: Column(
        children: [
          Toolbar(title: "สวัสดี ${_userData.doctorInfoModel?.displayName}"),
          Expanded(
            child: Container(
              width: 80 * MediaQuery.of(context).size.width / 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        _goToDoctorDiagnosePage(context);
                      },
                      child: BlossomCircleAvatar(
                        80,
                        fileStorePath: _userData.doctorInfoModel?.displayPhoto,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  BlossomText(
                    "${_userData.doctorInfoModel?.firstName} ${_userData.doctorInfoModel?.lastName}",
                    size: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlossomText(
                    "${_userData.doctorInfoModel?.story}",
                    size: 14,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToDoctorDiagnosePage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return DoctorDiagnoseProvider();
        },)
      ],
      child: DoctorDiagnosePage(),);
    }));
  }
}
