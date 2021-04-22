import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/doctor/doctor_provider.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/page/doctor_info/doctor_info_page.dart';
import 'package:blossom_clinic/page/doctor_info/doctor_info_provider.dart';
import 'package:blossom_clinic/widget/doctor_card.dart';
import 'package:blossom_clinic/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatelessWidget {

  DoctorProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.getDoctorList(context);
    return BaseScreen(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Toolbar(title: "พบแพทย์",),
            Container(
              height: 30,
            ),
            Expanded(child: Container(
              child: Consumer<DoctorProvider>(
                builder: (BuildContext context, DoctorProvider value, Widget child) {
                  return ListView.builder(
                      itemCount: value.listDoctor?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              DoctorCard(value.listDoctor[index],() {
                                _goToDoctorInfoPage(context, value.listDoctor[index]);
                              }),
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 30),
                                height: 1,
                                color: Color(0xFF8D8D8D),
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _goToDoctorInfoPage(BuildContext context, DoctorInfoModel _doctorInfoModel) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => DoctorInfoProvider(Injector.appInstance.get()),)
      ],
      child: DoctorInfoPage(_doctorInfoModel),);
    }));
  }
}
