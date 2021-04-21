
import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_page.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_provider.dart';
import 'package:blossom_clinic/page/doctor_info/doctor_info_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorInfoPage extends StatefulWidget {
  DoctorInfoModel _doctorInfoModel;

  DoctorInfoPage(this._doctorInfoModel);

  @override
  _DoctorInfoPageState createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {

  DoctorInfoProvider _doctorInfoProvider;
  String doctorProfileUrl = "";

  @override
  void initState() {
    super.initState();
    getDoctorProfileUrl();
  }

  @override
  Widget build(BuildContext context) {
    _doctorInfoProvider = Provider.of(context, listen: false);
    return BaseScreen(
      safeAreaBottom: false,
      child: Consumer<DoctorInfoProvider>(builder: (BuildContext context, DoctorInfoProvider value, Widget child) {
        return Column(
          children: [
            ToolbarBack(
              title: widget._doctorInfoModel?.displayName ?? "",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: 80 * MediaQuery.of(context).size.width / 100,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: BlossomTheme.white,
                            backgroundImage: NetworkImage(doctorProfileUrl),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlossomText(
                                    widget._doctorInfoModel?.displayName ?? "",
                                    color: BlossomTheme.darkPink,
                                    size: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  BlossomText("${widget._doctorInfoModel?.firstName ?? ""}\n${widget._doctorInfoModel?.lastName ?? ""}",
                                      color: BlossomTheme.black, size: 17)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 28),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: BlossomText(
                              "วันที่ต้องการปรึกษาแพทย์",
                              color: BlossomTheme.black,
                              size: 15,
                            )),
                      ),
                      Container(
                        height: 16,
                      ),
                      value == null ? BlossomProgressIndicator() : GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(0.0),
                        crossAxisSpacing: 10.0,
                        crossAxisCount: 4,
                        mainAxisSpacing: 28.0,
                        childAspectRatio: 3 / 1.5,
                        children: [Container()],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonPinkGradient("ต่อไป", true ,() {
              _goToConfirmConsultPage(context);
            },
              width: MediaQuery.of(context).size.width,
              height: 60,)
          ],
        );
      },),
    );
  }

  void _goToConfirmConsultPage(BuildContext context) {
    Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ConfirmConsultProvider())
      ],
      child: ConfirmConsultPage(),);
    }));
  }

  Future<void> getDoctorProfileUrl() async {
    doctorProfileUrl = await FirebaseStorage.instance.ref(widget._doctorInfoModel.displayPhoto).getDownloadURL();
    setState(() {

    });
  }
}
