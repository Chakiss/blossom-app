import 'package:blossom_clinic/blossom_theme.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'call_customer_provider.dart';

class CallCustomerPage extends StatelessWidget {

  P2PSession _callSession;
  CallCustomerProvider _provider;
  bool _isMuteAudio = false;
  bool _isVideoEnable = true;

  CallCustomerPage(this._callSession);

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.initCallSession(context, _callSession);
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Container(child: Consumer<CallCustomerProvider>(
                      builder: (BuildContext context, CallCustomerProvider value, Widget child) {
                        return value.videoView == null ? Container() : value.videoView;
                      })),
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
                                child: Consumer<CallCustomerProvider>(
                                builder: (BuildContext context, CallCustomerProvider value, Widget child) {
                              return value.videoViewSelf == null ? Container() : value.videoViewSelf;
                            })),
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
                          setMuteAudio();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SvgPicture.asset("assets/ic_microphone.svg")),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          setVideoEnableDisable();
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

  void setMuteAudio() {
    if (_callSession != null) {
      if (_isMuteAudio) {
        _isMuteAudio = false;
      } else {
        _isMuteAudio = true;
      }
      _callSession.setMicrophoneMute(_isMuteAudio);
    }
  }

  void setVideoEnableDisable() {
    if (_callSession != null) {
      if (_isVideoEnable) {
        _isVideoEnable = false;
      } else {
        _isVideoEnable = true;
      }
      _callSession.setVideoEnabled(_isVideoEnable);
    }
  }
}
