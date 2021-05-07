import 'package:blossom_clinic/model/appointment_model.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';

class CustomerHistoryPostPage extends StatelessWidget {
  Post _post;

  CustomerHistoryPostPage(this._post);

  @override
  Widget build(BuildContext context) {
    return !_post.isCompleted
        ? Container(
            child: Center(
              child: BlossomText(
                "ไม่พบข้อมูลการวินิจฉัย",
                size: 20,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 7 * MediaQuery.of(context).size.width / 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlossomText(
                      "ลักษณะสภาพผิว",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlossomText(
                      "${_post.skinOverview}",
                      size: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlossomText(
                      "ลักษณะผิว",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlossomText(
                      "${_post.skinType}",
                      size: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlossomText(
                      "วินิฉัยโรค",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlossomText(
                      "${_post.diagnoses.isEmpty ? "-" : _post.diagnoses}",
                      size: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlossomText(
                      "แผนการรักษา",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlossomText(
                      "${_post.carePlan}",
                      size: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlossomText(
                      "ข้อแนะนำวิธีการดูแลตัวเอง",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlossomText(
                      "${_post.careRecommendation}",
                      size: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlossomText(
                      "แนะนำผลิตภัณฑ์ที่ควรใช้",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlossomText(
                      "${_post.productsRecommendation}",
                      size: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlossomText(
                      "นัดครั้งถัดไป",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlossomText(
                      "${_post.nextAppointment.replaceAll("days", "วัน")}",
                      size: 16,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )));
  }
}
