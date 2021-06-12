import 'package:blossom_clinic/page/facebook_update_profile/facebook_update_profile_provider.dart';
import 'package:blossom_clinic/widget/blossom_text.dart';
import 'package:blossom_clinic/widget/button_pink_gradient.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/text_stroke_black.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../blossom_theme.dart';

class FacebookUpdateProfilePage extends StatefulWidget {
  String _email, _name;
  Map<String, dynamic> _mapResult;

  FacebookUpdateProfilePage(this._email, this._name, this._mapResult);

  @override
  _FacebookUpdateProfilePageState createState() => _FacebookUpdateProfilePageState();
}

class _FacebookUpdateProfilePageState extends State<FacebookUpdateProfilePage> {
  FacebookUpdateProfileProvider _provider;
  TextEditingController _emailTextController;
  TextEditingController _phoneNumberTextController;
  TextEditingController _nameTextController;
  TextEditingController _lastNameTextController;
  DateTime _selectedDate;
  final _dateFormat = DateFormat("d MMM yyyy", "TH");

  @override
  void initState() {
    super.initState();
    String name = "";
    String lastName = "";
    if (widget._name?.isNotEmpty ?? false) {
      name = widget._name.split(" ")[0] ?? "";
      lastName = widget._name.split(" ")[1] ?? "";
    }
    _provider = Provider.of(context, listen: false);
    _emailTextController = TextEditingController(text: widget._email ?? "");
    _phoneNumberTextController = TextEditingController();
    _nameTextController = TextEditingController(text: name);
    _lastNameTextController = TextEditingController(text: lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlossomTheme.white,
      body: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 100 * MediaQuery.of(context).size.width / 100,
                  child: Image.asset("assets/nav_bar.png"),
                ),
              ),
              SafeArea(
                  child: ToolbarBack(
                title: "เพิ่มข้อมูลผู้ใช้",
              )),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: 80 * MediaQuery.of(context).size.width / 100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "อีเมล",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  widget._email?.isEmpty ?? true
                      ? TextFieldStrokeBlack(
                          "",
                          textController: _emailTextController,
                        )
                      : TextStrokeBlack(
                          widget._email ?? "",
                          enable: false,
                        ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "เบอร์โทรศัพท์",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: _phoneNumberTextController,
                    maxLength: 10,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "ชื่อ",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: _nameTextController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "นามสกุล",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFieldStrokeBlack(
                    "",
                    textController: _lastNameTextController,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlossomText(
                      "วันเกิด",
                      size: 16,
                      color: BlossomTheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      var currentTime = DateTime.now();
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1970),
                          maxTime: DateTime(currentTime.year, currentTime.month, currentTime.day),
                          theme: DatePickerTheme(
                              headerColor: BlossomTheme.white,
                              backgroundColor: BlossomTheme.white,
                              itemStyle:
                              TextStyle(color: BlossomTheme.darkPink, fontWeight: FontWeight.bold, fontSize: 18),
                              doneStyle: TextStyle(color: BlossomTheme.darkPink, fontSize: 16)),
                          onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          }, currentTime: _selectedDate ?? DateTime.now(), locale: LocaleType.th);
                      // final DateTime picked = await showDatePicker(
                      //     context: context,
                      //     initialDate: DateTime.now(),
                      //     // Refer step 1
                      //     firstDate: DateTime(1970),
                      //     lastDate: DateTime.now(),
                      //     builder: (BuildContext context, Widget child) {
                      //       return Theme(
                      //         data: ThemeData.dark().copyWith(
                      //           colorScheme: ColorScheme.dark(
                      //             primary: BlossomTheme.pink,
                      //             onPrimary: BlossomTheme.black,
                      //             surface: BlossomTheme.darkPink,
                      //             onSurface: BlossomTheme.black,
                      //           ),
                      //           dialogBackgroundColor: BlossomTheme.white,
                      //         ),
                      //         child: child,
                      //       );
                      //     });
                      // if (picked != null)
                      //   setState(() {
                      //     _selectedDate = picked;
                      //   });
                    },
                    child: TextStrokeBlack(
                      _selectedDate == null ? "" : _dateFormat.format(_selectedDate),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonPinkGradient(
                    "ต่อไป",
                    true,
                    () {
                      _provider.goToFacebookUpdateProfileSecondPage(
                          context,
                          widget._mapResult,
                          _emailTextController.text,
                          _phoneNumberTextController.text ?? "",
                          _nameTextController.text,
                          _lastNameTextController.text,
                          // _selectedDate == null ? null : DateFormat("yyyy-MM-dd").format(_selectedDate));
                          _selectedDate == null ? DateFormat("yyyy-MM-dd").format(DateTime.now()) : DateFormat("yyyy-MM-dd").format(_selectedDate));
                    },
                    width: 30 * MediaQuery.of(context).size.width / 100,
                    height: 40,
                    radius: 6,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
