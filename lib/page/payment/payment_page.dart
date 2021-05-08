import 'package:blossom_clinic/page/payment/payment_provider.dart';
import 'package:blossom_clinic/utils/route_manager.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:blossom_clinic/widget/custom_expansion_tile.dart' as custom;
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class PaymentPage extends StatefulWidget {
  String _orderId;
  int _price;

  PaymentPage(this._orderId, this._price, {Key key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.pink,
      body: SafeArea(
          child: Column(
        children: [
          ToolbarBack(
            title: "เลือกช่องทางการชำระเงิน",
          ),
          Expanded(
              child: Material(
            color: BlossomTheme.white,
            child: ListView(
              children: [
                Container(
                  color: BlossomTheme.white,
                  height: 1,
                ),
                custom.ExpansionTile(
                  backgroundColor: BlossomTheme.pink,
                  headerBackgroundColor: BlossomTheme.pink,
                  iconColor: BlossomTheme.white,
                  title: BlossomText(
                    "PromptPay",
                    size: 16,
                    color: BlossomTheme.white,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        _provider.callServiceGenerateScbQrPromptPayUseCase(context, widget._orderId, widget._price);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: BlossomTheme.white,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/ic_logo_scb.png",
                              width: 42,
                              height: 42,
                              color: BlossomTheme.pink,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: BlossomText(
                              "Scb PromptPay",
                              size: 15,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   color: BlossomTheme.white,
                //   height: 1,
                // ),
                // custom.ExpansionTile(
                //   backgroundColor: BlossomTheme.pink,
                //   headerBackgroundColor: BlossomTheme.pink,
                //   iconColor: BlossomTheme.white,
                //   title: BlossomText(
                //     "InternetBanking",
                //     size: 16,
                //     color: BlossomTheme.white,
                //   ),
                //   children: [
                //     Column(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             _provider.callServiceOmiseCharge(
                //                 context, "internet_banking_scb", widget._orderId, widget._price);
                //           },
                //           child: Container(
                //             padding: const EdgeInsets.all(10),
                //             color: BlossomTheme.white,
                //             child: Row(
                //               children: [
                //                 Image.asset(
                //                   "assets/ic_logo_scb.png",
                //                   width: 42,
                //                   height: 42,
                //                 ),
                //                 SizedBox(
                //                   width: 16,
                //                 ),
                //                 Expanded(
                //                     child: BlossomText(
                //                   "Siam Commercial Bank",
                //                   size: 15,
                //                 ))
                //               ],
                //             ),
                //           ),
                //         ),
                //         Container(
                //           color: BlossomTheme.pink,
                //           height: 1,
                //         )
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             _provider.callServiceOmiseCharge(
                //                 context, "internet_banking_bbl", widget._orderId, widget._price);
                //           },
                //           child: Container(
                //             padding: const EdgeInsets.all(10),
                //             color: BlossomTheme.white,
                //             child: Row(
                //               children: [
                //                 Image.asset(
                //                   "assets/ic_logo_bbl.png",
                //                   width: 42,
                //                   height: 42,
                //                 ),
                //                 SizedBox(
                //                   width: 16,
                //                 ),
                //                 Expanded(
                //                     child: BlossomText(
                //                   "Bangkok Bank Public Company Limited",
                //                   size: 15,
                //                 ))
                //               ],
                //             ),
                //           ),
                //         ),
                //         Container(
                //           color: BlossomTheme.pink,
                //           height: 1,
                //         )
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             _provider.callServiceOmiseCharge(
                //                 context, "internet_banking_ktb", widget._orderId, widget._price);
                //           },
                //           child: Container(
                //             padding: const EdgeInsets.all(10),
                //             color: BlossomTheme.white,
                //             child: Row(
                //               children: [
                //                 Image.asset(
                //                   "assets/ic_logo_ktb.png",
                //                   width: 42,
                //                   height: 42,
                //                 ),
                //                 SizedBox(
                //                   width: 16,
                //                 ),
                //                 Expanded(
                //                     child: BlossomText(
                //                   "Krungthai Bank Public Company Limited",
                //                   size: 15,
                //                 ))
                //               ],
                //             ),
                //           ),
                //         ),
                //         Container(
                //           color: BlossomTheme.pink,
                //           height: 1,
                //         )
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             _provider.callServiceOmiseCharge(
                //                 context, "internet_banking_bay", widget._orderId, widget._price);
                //           },
                //           child: Container(
                //             padding: const EdgeInsets.all(10),
                //             color: BlossomTheme.white,
                //             child: Row(
                //               children: [
                //                 Image.asset(
                //                   "assets/ic_logo_bay.png",
                //                   width: 42,
                //                   height: 42,
                //                 ),
                //                 SizedBox(
                //                   width: 16,
                //                 ),
                //                 Expanded(
                //                     child: BlossomText(
                //                   "Bank of Ayudhya Public Company Limited",
                //                   size: 15,
                //                 ))
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                Container(
                  color: BlossomTheme.white,
                  height: 1,
                ),
                custom.ExpansionTile(
                  backgroundColor: BlossomTheme.pink,
                  headerBackgroundColor: BlossomTheme.pink,
                  iconColor: BlossomTheme.white,
                  title: BlossomText(
                    "Credit/Debit",
                    size: 16,
                    color: BlossomTheme.white,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, RouteManager.routeOmise(widget._orderId, widget._price));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: BlossomTheme.white,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/ic_logo_credit_card.png",
                              width: 42,
                              height: 42,
                              color: BlossomTheme.pink,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: BlossomText(
                              "Visa, MasterCard",
                              size: 15,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
