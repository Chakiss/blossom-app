import 'package:blossom_clinic/blossom_theme.dart';
import 'package:blossom_clinic/page/chat/chat_provider.dart';
import 'package:blossom_clinic/utils/user_data.dart';
import 'package:blossom_clinic/widget/blossom_progress_indicator.dart';
import 'package:blossom_clinic/widget/chat_item.dart';
import 'package:blossom_clinic/widget/text_field_stroke_black.dart';
import 'package:blossom_clinic/widget/toolbar_back.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {

  ChatProvider _provider;
  TextEditingController _messageTextEditController = TextEditingController();
  UserData _userData = Injector.appInstance.get();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of(context, listen: false);
    _provider.signInConnectyCube(context);
    return Consumer<ChatProvider>(
      builder: (BuildContext context, ChatProvider value, Widget child) {
        return Scaffold(
          backgroundColor: BlossomTheme.darkPink,
          body: SafeArea(
            child: Container(
              color: BlossomTheme.white,
              child: Column(
                children: [
                  ToolbarBack(
                    title: value.doctorInfoModel?.firstName == null && value.doctorInfoModel?.lastName == null
                        ? ""
                        : "${value.doctorInfoModel?.firstName} ${value.doctorInfoModel?.lastName}",
                    backgroundColor: BlossomTheme.darkPink,
                    titleSize: 16,
                    padding: 8,
                  ),
                  Expanded(
                      child: value.chatList?.isEmpty ?? true
                          ? Container(
                        color: BlossomTheme.white,
                        child: Center(
                          child: BlossomProgressIndicator(),
                        ),
                      )
                          : ListView.builder(
                        key: UniqueKey(),
                        reverse: true,
                        itemCount: value.chatList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return ChatItem(
                            value.chatList[index],
                            value.chatList[index].senderId ==
                                _userData.userProfileModel.referenceConnectyCubeID,
                            key: UniqueKey(),
                          );
                        },
                      )),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: BlossomTheme.darkPink,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: TextFieldStrokeBlack(
                              "พิมพ์ข้อความ",
                              width: null,
                              strokeColor: BlossomTheme.white,
                              textController: _messageTextEditController,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _provider.sendMessage(_messageTextEditController.text);
                            _messageTextEditController.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.send,
                              color: BlossomTheme.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
