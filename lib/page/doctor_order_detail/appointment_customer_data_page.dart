import 'package:blossom_clinic/model/user_profile_model.dart';
import 'package:blossom_clinic/page/doctor_order_detail/appointment_customer_data_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentCustomerDataPage extends StatefulWidget {
  AppointmentCustomerDataPage({Key key}) : super(key: key);

  @override
  _AppointmentCustomerDataPageState createState() =>
      _AppointmentCustomerDataPageState();
}

class _AppointmentCustomerDataPageState
    extends State<AppointmentCustomerDataPage> {
  AppointmentCustomerDataProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
    _provider.getUserProfileById();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentCustomerDataProvider>(
      builder: (BuildContext context, AppointmentCustomerDataProvider value,
          Widget child) {
        if (value.isFirstTime) {
          return BlossomProgressIndicator();
        } else {
          if (value.userProfileModel == null) {
            return Container(
                child: Center(
              child: BlossomText(
                "ไม่พบข้อมูล",
                fontWeight: FontWeight.bold,
                size: 18,
              ),
            ));
          } else {
            return SingleChildScrollView(
                child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  horizontal: 7 * MediaQuery.of(context).size.width / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlossomText(
                    "ลักษณะผิว",
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _getSkinType(value.userProfileModel),
                  SizedBox(
                    height: 10,
                  ),
                  BlossomText(
                    "ลักษณะสิว",
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _getAcneType(value.userProfileModel),
                  SizedBox(
                    height: 10,
                  ),
                  BlossomText(
                    "เคยรักษาสิว",
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _getAcneIsCared(value.userProfileModel),
                  SizedBox(
                    height: 10,
                  ),
                  BlossomText(
                    "ประวัติแพ้ยา",
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  _getDrugAllergy(value.userProfileModel),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ));
          }
        }
      },
    );
  }

  Widget _getSkinType(UserProfileModel userProfileModel) {
    String skinType = "";
    switch (userProfileModel.skinType) {
      case 1:
        skinType = "ผิวแห้ง";
        break;
      case 2:
        skinType = "ผิวมันทั่วใบหน้า";
        break;
      case 3:
        skinType = "ผิวผสม, มันเฉพาะ T zone";
        break;
      case 4:
        skinType = "ผิวแพ้ง่าย";
        break;
    }
    return BlossomText(
      skinType,
      size: 16,
    );
  }

  Widget _getAcneType(UserProfileModel userProfileModel) {
    String acneType = "";
    userProfileModel.acneTypes.forEach((element) {
      switch (element) {
        case "1":
          acneType = acneType + "สิวอุดตัน, ";
          break;
        case "2":
          acneType = acneType + "สิวอักเสบ, ";
          break;
        case "3":
          acneType = acneType + "สิวอักเสบ สัมพันธ์กับรอบเดือน, ";
          break;
        case "4":
          acneType = acneType + "รอยสิว, ";
          break;
        case "5":
          acneType = acneType + "หลุมสิว, ";
          break;
      }
    });
    if (acneType.endsWith(", ")) {
      acneType = acneType.substring(0, acneType.length - 2);
    }
    return BlossomText(
      acneType,
      size: 16,
    );
  }

  Widget _getAcneIsCared(UserProfileModel userProfileModel) {
    if (userProfileModel.acneIsCared) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlossomText(
            "เคย",
            size: 16,
          ),
          Row(
            children: [
              BlossomText(
                "note: ",
                fontWeight: FontWeight.bold,
                size: 16,
              ),
              BlossomText(
                "${userProfileModel.acneCaredNoted ?? ""}",
                size: 16,
              ),
            ],
          ),
        ],
      );
    } else {
      return BlossomText(
        "ไม่เคย",
        size: 16,
      );
    }
  }

  Widget _getDrugAllergy(UserProfileModel userProfileModel) {
    if (userProfileModel.drugAllergyStatus) {
      String drugAllergy = "";
      userProfileModel.drugAllergyItems.forEach((element) {
        drugAllergy = drugAllergy + "$element, ";
      });
      if (drugAllergy.endsWith(", ")) {
        drugAllergy = drugAllergy.substring(0, drugAllergy.length - 2);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlossomText(
            "แพ้",
            size: 16,
          ),
          Row(
            children: [
              BlossomText(
                "note: $drugAllergy",
                fontWeight: FontWeight.bold,
                size: 16,
              ),
              BlossomText(
                "${userProfileModel.acneCaredNoted ?? ""}",
                size: 16,
              ),
            ],
          ),
        ],
      );
    } else {
      return BlossomText(
        "ไม่แพ้",
        size: 16,
      );
    }
  }
}
