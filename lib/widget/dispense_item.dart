import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/product_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/text_stroke_black.dart';
import 'package:flutter/material.dart';

class DispenseItem extends StatefulWidget {

  ProductModel _productModel;

  DispenseItem(this._productModel);

  @override
  _DispenseItemState createState() => _DispenseItemState();
}

class _DispenseItemState extends State<DispenseItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: Padding(
        // padding: EdgeInsets.symmetric(horizontal: 10 * MediaQuery.of(context).size.width / 100),
        padding: EdgeInsets.symmetric(horizontal: 8 * MediaQuery.of(context).size.width / 100),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      child: Image.network(widget._productModel?.image ?? ""),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          widget._productModel.name ?? "",
                          size: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "${widget._productModel.price} บาท",
                          size: 15,
                        ))
                  ],
                )),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        BlossomText(
                          "จำนวน",
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextStrokeBlack(
                          "0",
                          width: 64,
                          height: 32,
                          size: 13,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        BlossomText(
                          "จำนวน",
                          size: 14,
                          color: BlossomTheme.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFEF567E), Color(0xFFE8A872)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )),
                              child: BlossomText(
                                "-",
                                size: 15,
                                color: BlossomTheme.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFEF567E), Color(0xFFE8A872)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )),
                              child: BlossomText(
                                "+",
                                size: 15,
                                color: BlossomTheme.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Container(
              color: BlossomTheme.black,
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
