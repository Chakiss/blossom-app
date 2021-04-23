import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/widget/doctor_bottom_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'doctor_main_provider.dart';

class DoctorMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DoctorMainProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      body: Container(
        child: Container(
          child: Column(
            children: [
              Expanded(child: Consumer<DoctorMainProvider>(
                builder: (BuildContext context, DoctorMainProvider value, Widget child) {
                  return value.page;
                },
              )),
              Container(
                color: BlossomTheme.white,
                child: SafeArea(
                    top: false, bottom: true, child: DoctorBottomTab(provider)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
