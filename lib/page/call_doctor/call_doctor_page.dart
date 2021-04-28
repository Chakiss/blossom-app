import 'package:blossom_clinic/blossom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'call_doctor_provider.dart';

class CallDoctorPage extends StatefulWidget {

  @override
  _CallDoctorPageState createState() => _CallDoctorPageState();
}

class _CallDoctorPageState extends State<CallDoctorPage> {
  CallDoctorProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
    _provider.signInConnectyCube(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Container(child: Consumer<CallDoctorProvider>(
                      builder: (BuildContext context, CallDoctorProvider value, Widget child) {
                    return value.videoView == null ? Container() : value.videoView;
                  })),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 25 * MediaQuery.of(context).size.width / 100,
                      margin: EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Container(child: Consumer<CallDoctorProvider>(
                            builder: (BuildContext context, CallDoctorProvider value, Widget child) {
                          return value.videoViewSelf == null ? Container() : value.videoViewSelf;
                        })),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 80.0,
                width: 80.0,
                child: FittedBox(
                  child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        await _provider.endCall();
                        Navigator.pop(context);
                      }),
                )),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          _provider.setVideoEnableDisable();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset("assets/ic_microphone.svg")),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          _provider.setVideoEnableDisable();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset("assets/ic_camera.svg")),
                  ],
                ),
              ),
            ),
            shape: CircularNotchedRectangle(),
            color: BlossomTheme.darkPink,
          ),
        )
      ],
    );
  }
}
