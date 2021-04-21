import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryItem extends StatelessWidget {

  Function(dynamic) listener;

  HistoryItem(this.listener);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 80 * MediaQuery.of(context).size.width / 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage("url"),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlossomText(
                        "Title",
                        size: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      BlossomText("Description", size: 12)
                    ],
                  ),
                )),
                ButtonPinkGradient("โทรหา", true, () {
                  listener.call("");
                },
                radius: 6,
                height: 32,
                textSize: 13,)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
            height: 1,
            color: Color(0xFF8D8D8D),
          )
        ],
      ),
    );
  }
}
