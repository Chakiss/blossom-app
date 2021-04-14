import 'package:blossom_clinic/model/response/get_book_history_response_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryItem extends StatelessWidget {

  GetBookingHistoryResponseModel _historyResponseModel;
  Function(GetBookingHistoryResponseModel) listener;

  HistoryItem(this._historyResponseModel, this.listener);

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
                  backgroundImage: NetworkImage(_historyResponseModel.image),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlossomText(
                        _historyResponseModel.title ?? "",
                        size: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      BlossomText(_historyResponseModel.description ?? "", size: 12)
                    ],
                  ),
                )),
                ButtonPinkGradient("โทรหา", true, () {
                  listener.call(_historyResponseModel);
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
