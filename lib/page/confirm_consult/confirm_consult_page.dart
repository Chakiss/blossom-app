import 'package:blossom_clinic/base/base_screen.dart';
import 'package:blossom_clinic/model/available_slot_model.dart';
import 'package:blossom_clinic/model/doctor_info_model.dart';
import 'package:blossom_clinic/model/slot_model.dart';
import 'package:blossom_clinic/page/add_customer_information/add_customer_information_page.dart';
import 'package:blossom_clinic/page/add_customer_information/add_customer_information_provider.dart';
import 'package:blossom_clinic/page/confirm_consult/confirm_consult_provider.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/consult_doctor_day_item.dart';
import 'package:blossom_clinic/widget/consult_doctor_time_item.dart';
import 'package:blossom_clinic/widget/dialog/custom_dialog_two_button.dart';
import 'package:blossom_clinic/widget/doctor_duration_choice.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class ConfirmConsultPage extends StatefulWidget {
  DoctorInfoModel _doctorInfoModel;
  AvailableSlotModel _availableSlotModel;

  ConfirmConsultPage(this._doctorInfoModel, this._availableSlotModel);

  @override
  _ConfirmConsultPageState createState() => _ConfirmConsultPageState();
}

class _ConfirmConsultPageState extends State<ConfirmConsultPage> {
  ConfirmConsultProvider _provider;
  List<SlotModel> _list;
  String selectedTime = "";
  DateFormat _dateFormat = DateFormat("d MMMM yyyy", "TH");

  @override
  void initState() {
    super.initState();
    _provider = Provider.of(context, listen: false);
    _provider.timeSlotModel = widget._availableSlotModel.timeSlots[0];
    _list = widget._availableSlotModel.timeSlots[0].slots;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      safeAreaBottom: true,
      child: Consumer<ConfirmConsultProvider>(
        builder: (BuildContext context, ConfirmConsultProvider value, Widget child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ToolbarBack(
                title: "ยืนยันการจอง",
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Container(
                  width: 80 * MediaQuery.of(context).size.width / 100,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "ระยะเวลาการปรึกษาแพทย์",
                          color: BlossomTheme.black,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DoctorDurationChoice(
                        widget._availableSlotModel.timeSlots,
                        listener: (timeSlot) {
                          value.timeSlotModel = timeSlot;
                          setState(() {
                            _provider.slotModel = null;
                            selectedTime = "";
                            _list = timeSlot.slots;
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        height: 1,
                        color: BlossomTheme.lightGray,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlossomText(
                          "เวลาที่ต้องการปรึกษาแพทย์",
                          color: BlossomTheme.black,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(0.0),
                        crossAxisSpacing: 10.0,
                        crossAxisCount: 4,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 3 / 1.5,
                        children: _generateDoctorTimeItem(),
                      ),
                    ],
                  ),
                )),
              ),
              Container(
                height: 1,
                color: BlossomTheme.lightGray,
              ),
              Container(
                width: 80 * MediaQuery.of(context).size.width / 100,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlossomText(
                      "ค่าใช้จ่ายในการปรึกษา ${_provider.timeSlotModel?.priceSale ?? 0} บาท",
                      color: BlossomTheme.black,
                      size: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    ButtonPinkGradient(
                      "ยืนยัน",
                      value.slotModel != null,
                      () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return CustomDialogTwoButton(
                                title: "ยืนยัน",
                                description: "คุณยืนยันที่จะจองคิว ${widget._doctorInfoModel?.displayName ?? ""} " +
                                    "ในวันที่ ${_dateFormat.format(widget._availableSlotModel.date)} " +
                                    "เวลา ${_provider.slotModel?.title ?? ""} " +
                                    "ระยะเวลา ${_provider.timeSlotModel.period} นาที " +
                                    "มีค่าใช้จ่ายในการปรึกษาทั้งสิ้น ${_provider.timeSlotModel?.priceSale ?? 0} บาท",
                                positiveButton: "ตกลง",
                                positiveListener: () {
                                  Navigator.pop(dialogContext);
                                  _provider.callServiceCreateAppointmentOrder(context, widget._doctorInfoModel, widget._availableSlotModel);
                                },
                                negativeButton: "ยกเลิก",
                                negativeListener: () {
                                  Navigator.pop(context);
                                });
                          },
                        );
                      },
                      height: 40,
                      radius: 4,
                      padding: EdgeInsets.only(left: 32, right: 32),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  List<ConsultDoctorTimeItem> _generateDoctorTimeItem() {
    return _list
        .map((e) => ConsultDoctorTimeItem(
              e,
              (slot) {
                setState(() {
                  _provider.slotModel = slot;
                  selectedTime = slot.title;
                });
              },
              selectedTime: selectedTime,
            ))
        .toList();
  }
}
