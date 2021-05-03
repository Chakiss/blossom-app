import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/model/shipnity_order_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class AppointmentDispenseItem extends StatefulWidget {
  Purchase _purchase;
  Function(Purchase) _listener;

  AppointmentDispenseItem(this._purchase, this._listener);

  @override
  _AppointmentDispenseItemState createState() => _AppointmentDispenseItemState();
}

class _AppointmentDispenseItemState extends State<AppointmentDispenseItem> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BlossomTheme.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    child: Image.network(widget._purchase.thumb ?? ""),
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
                        widget._purchase.name ?? "",
                        size: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: BlossomText(
                        "${widget._purchase.price} บาท",
                        size: 15,
                      ))
                ],
              )),
              Row(
                children: [
                  BlossomText(
                    "จำนวน",
                    size: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BlossomText(
                      "${widget._purchase.quantity}",
                      size: 15,
                    ),
                  ),
                  BlossomText(
                    "ชิ้น",
                    size: 15,
                    fontWeight: FontWeight.bold,
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
    );
  }
}
