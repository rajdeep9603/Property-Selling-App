import 'package:com.propacy.b2c/screen/chat/chat_screen/chat_screen_view_model.dart';
import 'package:com.propacy.b2c/screen/chat/chat_screen/widget/bottom_input_bar.dart';
import 'package:com.propacy.b2c/screen/chat/chat_screen/widget/chat_top_bar.dart';
import 'package:com.propacy.b2c/screen/chat/chat_screen/widget/message_box.dart';

import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatefulWidget {
  final String uid;
  final String name;
  final String? fcmToken;
  final String? anpotherPhone;
  final String? peerType;

  const ChatScreen(
      {Key? key,
      required this.uid,
      required this.name,
      this.fcmToken,
      this.anpotherPhone,
        this.peerType
      })
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init(widget.uid, widget.name, widget.anpotherPhone!, context,widget.peerType!);
      },
      viewModelBuilder: () => ChatScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.darkBlue,
          body: Column(
            children: [
              ChatTopBar(
                onBackBtnTap: model.onBackBtnTap,
                name: widget.name,
                callApi: model.call,
              ),
              SizedBox(height: 10,),
              Expanded(
                child: model.chatId == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : FirebaseAnimatedList(
                        controller: scrollController,
                        reverse: false,
                        query: FirebaseDatabase.instance
                            .ref()
                            .child(model.chatId!),
                        itemBuilder: (BuildContext context, DataSnapshot snap,
                            Animation<double> animation, int index) {
                          if (snap.key != "userDetails") {
                            Map contact = snap.value as Map;
                            List<Map>map=[];
                            map.add(contact);
                            print(map);
                            DateTime d = DateFormat('dd/MM/yyyy, kk:mm')
                                .parse(contact['timestamp'].toString());
                            return MessageBox(
                                message: contact['content'] ?? "",
                                time:contact['timestamp'].toString().split(",").last.toString(),
                                leftSide: contact['id'] != userUid,
                                type: "text");
                          } else {
                            return Container();
                          }
                        }),
              ),
              BottomInputBar(
                controller: model.msgController,
                onMsgSnd: model.onMsgSend,
                onChange: model.onTextFieldChange,
                showBtnColor: model.showBtnColor,
                scrollController: scrollController,
              ),
            ],
          ),
        );
      },
    );
  }

}
