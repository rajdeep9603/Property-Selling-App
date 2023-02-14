import 'package:com.propacy.b2c/model/chat_model/message_model.dart';
import 'package:com.propacy.b2c/model/chat_model/notification_model.dart';
import 'package:com.propacy.b2c/model/chat_model/user_model.dart';
import 'package:com.propacy.b2c/rest_api/phone_call_api.dart';
import 'package:com.propacy.b2c/services/chat_service/chat_service.dart';
import 'package:com.propacy.b2c/services/message_service.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
final ScrollController? scrollController = ScrollController();
class ChatScreenViewModel extends BaseViewModel {
  void init(String uid, String name, String userPhone, BuildContext conxt,
      String peerType) async {

    FirebaseAnalyticsService.sendAnalyticsEvent3(
        Str.cChat, Str.load, Str.lChat_view_page,uid);
    anotherUserId = uid;
    Future.delayed(Duration(seconds: 2), () {
      scrollController!.animateTo(
        scrollController!.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
    await getCurrentDeviceToken();
    title = name;
    userphone = userPhone;
    context = conxt;
    peermType = peerType;

    //anotherUserFcmToken = fcmToken;
    //scrollController!.position.maxScrollExtent;
    getChatId();
    await getOtherFcmToken();
  }

  String? chatId;
  String anotherUserId = '';

  BuildContext? context;
  String? peermType;

  String user2Name = 'Nadir Mistry';
  TextEditingController msgController = TextEditingController();
  bool showBtnColor = false;
  String? userFcmToken;
  MessageService messageService = MessageService();
  String? title;
  String? anotherUserFcmToken;
  String? userphone;
  String? phoneNo;
  String? deviceToken;

  Future<void> getChatId() async {
    List<UserDetail> userDetail = [];
    UserModel userModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString("userMobile");
    phoneNo = phoneNumber;
    await ChatService.getCurrentUserUid();
    userFcmToken = await messageService.getFcmTokne();
    chatId = await ChatService.getChatId(anotherUserId);
    print("chatId");
    print(chatId);
    print(userUid);
    String notificationbody;
    notificationbody = msgController.text;
    if (chatId == null) {
      chatId = anotherUserId + userUid;
      print(chatId);
      userDetail.add(UserDetail(userId: userUid, userName: phoneNumber));
      userDetail.add(UserDetail(userName: title, userId: anotherUserId));

      await ChatService.sendMessage(
        MessageModel(
          content: "Hello,How may I help you?",
          id: anotherUserId,
          timestamp:
              DateFormat('dd/MM/yyyy, kk:mm').format(DateTime.now()).toString(),
          user: 'User',
        ),
        chatId!,
      );
      await ChatService.setUserDetail(userDetail, chatId!);
      SendNotificationModel notification = SendNotificationModel(
        title: title!,
        body: notificationbody,
        fcmToken: anotherUserFcmToken,
        roomId: chatId,
      );
      messageService.sendNotification(notification);
      ChatService.setChatUser(anotherUserId.toString(), phoneNumber!, title!,
          chatId!, "Hello,How may I help you?", peermType!);

      ChatService.updateChatUser(anotherUserId.toString(), title!, title!,
          chatId!, "Hello,How may I help you?");
    }
    notifyListeners();
  }

  void onBackBtnTap() {
    FirebaseAnalyticsService.sendAnalyticsEvent3(
        Str.cChat, Str.click, Str.lChat_view_page_back_button,anotherUserId);
    Get.back();
  }
  void scrollJump()async{
    if(scrollController!.position!=null){
      print(scrollController!.position);
      scrollController!.position.animateTo(scrollController!.position.maxScrollExtent,duration: Duration(seconds: 1),curve: Curves.easeOut);
      print(scrollController!.position.maxScrollExtent);
     notifyListeners();
    }
  }

  getCurrentDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    deviceToken = await prefs.getString("deviceToken");
    print(deviceToken);
    notifyListeners();
  }

  int limit = 5;

  Future<void> onMsgSend() async {
    if (msgController.text == '') {
      return;
    }
    await ChatService.sendMessage(
      MessageModel(
        content: msgController.text,
        id: userUid,
        timestamp:
            DateFormat('dd/MM/yyyy, kk:mm').format(DateTime.now()).toString(),
        user: 'User',
      ),
      chatId!,
    );
    ChatService.updateValues(
        anotherUserId, chatId!, msgController.text, deviceToken!);
    ChatService.updateCurrentUserValues(
        anotherUserId, chatId!, msgController.text, anotherUserFcmToken!);
    String notificationbody;
    notificationbody = msgController.text;
    SendNotificationModel notification = SendNotificationModel(
      title: title!,
      body: notificationbody,
      fcmToken: anotherUserFcmToken,
      roomId: chatId,
    );
    messageService.sendNotification(notification);

    scrollController!.jumpTo(scrollController!.position.maxScrollExtent);
    limit++;
    notifyListeners();
    msgController.clear();
  }

  void onTextFieldChange(String? value) {
    if (msgController.text == '') {
      showBtnColor = false;
      notifyListeners();
    } else {
      if (showBtnColor == false) {
        showBtnColor = true;
        notifyListeners();
      }
    }
  }

  Future<void> getOtherFcmToken() async {
    await ChatService.database
        .ref('users')
        .child(anotherUserId)
        .once()
        .then((value) {
      Map data = value.snapshot.value as Map;
      print(data);
      print(data['deviceToken'].toString());
      anotherUserFcmToken = data['deviceToken'].toString();
      print(anotherUserFcmToken);
    });

    /*   DataSnapshot token =
        await ChatService.database.ref('users').child(anotherUserId).get();
    var value = token.value as Map;
    anotherUserFcmToken = value['deviceToken'];
    print(value['deviceToken']);*/
  }

  void call() {
    FirebaseAnalyticsService.sendAnalyticsEvent3(Str.cCall, Str.click, Str.lCall,anotherUserId);
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        context: context!,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: Get.width,
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      color: Color(0xFF34393E),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 20),
                            child: Text(
                              "Dialing...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 1,
                            width: Get.width,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              width: Get.width,
                              child: Text(
                                "You will receive a call from 080-45025365 and we will bridge both of you",
                                maxLines: 2,
                                style: TextStyle(color: Colors.white),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 1,
                            width: Get.width,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.all(10),
                                    child: Text("Cancel"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    print(userphone);
                                    print(phoneNo);
                                    PhoneCallApi.callApi(userphone!, phoneNo!);
                                    Get.back();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.all(10),
                                    child: Text("Okay"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));

    //PhoneCallApi.callApi(userphone!,phoneNo! );
  }
}
