import 'dart:async';
import 'dart:io';

import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'customer_incoming_call_provider.dart';

class CustomerIncomingCallPage extends StatefulWidget {
  P2PSession callSession;

  CustomerIncomingCallPage(this.callSession);

  @override
  _CustomerIncomingCallPageState createState() => _CustomerIncomingCallPageState();
}

class _CustomerIncomingCallPageState extends State<CustomerIncomingCallPage> {
  FlutterSound _flutterSound = FlutterSound();
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    CustomerIncomingCallProvider provider = Provider.of(context, listen: false);
    provider.handleHangUpCall(context, widget.callSession);
    provider.getUserDetail(widget.callSession);
    _playSound();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Container()),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFE8A872).withOpacity(0.1), Color(0xFFEF567E).withOpacity(0.1)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.red)),
                  Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFE8A872).withOpacity(0.3), Color(0xFFEF567E).withOpacity(0.3)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.red)),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFE8A872).withOpacity(0.5), Color(0xFFEF567E).withOpacity(0.5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.red),
                    child: Container(),
                  )
                ],
              ),
              Consumer<CustomerIncomingCallProvider>(builder: (BuildContext context, CustomerIncomingCallProvider value, Widget child) {
                return BlossomText(value.customerName ?? "", color: BlossomTheme.white, size: 20,);
              },),
              Expanded(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      widget.callSession.reject();
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 7 * MediaQuery.of(context).size.width / 100),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 10 * MediaQuery.of(context).size.width / 100,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.callSession.callType == CallType.AUDIO_CALL) {
                        Navigator.pushReplacement(context, RouteManager.routeCustomerReceiveVoiceCallDoctor(widget.callSession, provider.doctorInfoModel));
                      } else {
                        Navigator.pushReplacement(context, RouteManager.routeCustomerReceiveCallDoctor(widget.callSession, provider.doctorInfoModel));
                      }
                    },
                    child: Image.asset(
                      "assets/animation_calling.gif",
                      width: 30 * MediaQuery.of(context).size.width / 100,
                      height: 30 * MediaQuery.of(context).size.width / 100,
                    ),
                  ),
                ],
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _playSound() async {
    var data = await rootBundle.load("assets/incoming_call.wav");
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/demo.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    await _flutterSound.setVolume(100);
    String url = tempFile.uri.toString();
    _flutterSound.startPlayer(url);
    _repeatSound(url);
  }

  void _repeatSound(String url) {
    _timer = new Timer(const Duration(milliseconds: 3000), () {
      _flutterSound.stopPlayer();
      _flutterSound.startPlayer(url);
      _repeatSound(url);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
