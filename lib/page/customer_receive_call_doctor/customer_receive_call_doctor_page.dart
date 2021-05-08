import 'package:blossom_clinic/blossom_theme.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_receive_call_doctor_provider.dart';

class CustomerReceiveCallDoctorPage extends StatelessWidget {

  P2PSession _callSession;
  CustomerReceiveCallDoctorProvider _provider;

  CustomerReceiveCallDoctorPage(this._callSession);

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.initCallSession(context, _callSession);
    return Consumer<CustomerReceiveCallDoctorProvider>(
        builder: (BuildContext context, CustomerReceiveCallDoctorProvider value, Widget child) {
          return Stack(
            children: [
              Scaffold(
                body: SafeArea(
                  child: Container(
                    child: Stack(
                      children: [
                        Container(child: value.videoView == null ? Container() : value.videoView),
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
                                  child: Container(
                                      child: value.videoViewSelf == null ? Container() : value.videoViewSelf),
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
                              await _provider.endCall(context);
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
                              child: Image.asset(_provider.isMuteAudio ? "assets/ic_mic_mute.png" : "assets/ic_mic_unmute.png", width: 60, height: 60,)),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                _provider.setVideoEnableDisable();
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Image.asset(_provider.isVideoEnable ? "assets/ic_camera_unmute.png" : "assets/ic_camera_mute.png", width: 60, height: 60,)),
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
        });
  }
}
