import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'call_doctor_provider.dart';

class CallDoctorPage extends StatelessWidget {
  CallDoctorProvider _provider;
  AppointmentModel _appointmentModel;

  CallDoctorPage(this._appointmentModel);

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.signInConnectyCube(context, _appointmentModel);
    return Container(
        child: Consumer<CallDoctorProvider>(builder: (BuildContext context, CallDoctorProvider value, Widget child) {
      return Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      child: value.videoView == null ? Container() : value.videoView,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 36 * MediaQuery.of(context).size.width / 100,
                            margin: EdgeInsets.only(top: 10, right: 10),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Container(child: value.videoViewSelf == null ? Container() : value.videoViewSelf),
                            ),
                          ),
                        ],
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
                            _provider.setMuteAudio();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Image.asset(value.isMuteAudio ? "assets/ic_mic_mute.png" : "assets/ic_mic_unmute.png", width: 60, height: 60,)),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            _provider.setVideoEnableDisable();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Image.asset(value.isVideoEnable ? "assets/ic_camera_unmute.png" : "assets/ic_camera_mute.png", width: 60, height: 60,)),
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
    }));
  }
}
