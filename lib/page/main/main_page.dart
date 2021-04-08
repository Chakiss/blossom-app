import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/doctor/doctor_page.dart';
import 'package:blossom_clinic/page/main/main_provider.dart';
import 'package:blossom_clinic/widget/bottom_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      body: Container(
        child: Container(
          child: Column(
            children: [
              Expanded(child: Consumer<MainProvider>(
                builder: (BuildContext context, MainProvider value, Widget child) {
                  return value.page;
                },
              )),
              Container(
                color: BlossomTheme.white,
                child: SafeArea(
                    top: false, bottom: true, child: BottomTab(provider)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
