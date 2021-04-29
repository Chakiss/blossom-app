import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'incoming_call_provider.dart';

class IncomingCallPage extends StatelessWidget {
  P2PSession callSession;

  IncomingCallPage(this.callSession);

  @override
  Widget build(BuildContext context) {
    IncomingCallProvider provider = Provider.of(context, listen: false);
    provider.handleHangUpCall(context, callSession);
    provider.getUserDetail(callSession);
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
              Consumer<IncomingCallProvider>(builder: (BuildContext context, IncomingCallProvider value, Widget child) {
                return BlossomText(value.customerName ?? "", color: BlossomTheme.white, size: 20,);
              },),
              Expanded(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      callSession.reject();
                      Navigator.pop(context);
                    },
                    child: Container(
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
                      Navigator.pushReplacement(context, RouteManager.routeCallCustomer(callSession));
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
}
