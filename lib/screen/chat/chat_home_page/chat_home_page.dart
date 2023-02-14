import 'package:com.propacy.b2c/screen/chat/chat_home_page/chat_home_page_view_model.dart';
import 'package:com.propacy.b2c/screen/chat/chat_home_page/widget/top_bar_area.dart';
import 'package:com.propacy.b2c/screen/chat/chat_home_page/widget/user_card.dart';
import 'package:com.propacy.b2c/services/chat_service/chat_service.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatHomePageViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ChatHomePageViewModel(),
      builder: (context, model, child) {
        var userd = model.userRef.child(userUid);
        print(userd);
        return Scaffold(
          backgroundColor: ColorRes.darkBlue,
          body:model.loader==true?Center(child: CircularProgressIndicator(),): Column(
            children: [
              TopBarArea(
                onBackBtnTap: model.onBackBtnTap,
              ),
              flag == false
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //no chat message
                            height: Get.height - 100,
                            width: Get.width,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppRes.thereNo,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle(
                                      textColor: ColorRes.textGrey,
                                      size: 16,
                                      weight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppRes.proPacyKeeps,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle(
                                      textColor: ColorRes.textGrey,
                                      size: 14,
                                      weight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  :model.loader==true?Expanded(child: Center(child: CircularProgressIndicator(),)): Expanded(
                      child: StreamBuilder<DatabaseEvent>(
                        stream: userd.onValue,
                        builder: (context, snap) {
                          if (snap.hasData &&
                              !snap.hasError &&
                              snap.data!.snapshot.value != null) {
                            Map data = snap.data!.snapshot.value as Map;
                            Map da=data['chatUsers'] as Map;
                            print(da);
                            List item = [];
                            List key = [];

                            da.forEach((index, data) {
                              key.add(index);
                              item.add({"key": index, ...data});
                            });

                            print(item);
                            return item.length == 0
                                ? Container(
                                    //no chat message
                                    height: Get.height - 100,
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppRes.thereNo,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle(
                                              textColor: ColorRes.textGrey,
                                              size: 16,
                                              weight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          AppRes.proPacyKeeps,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle(
                                              textColor: ColorRes.textGrey,
                                              size: 14,
                                              weight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: item.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => model.onUserTap(
                                            item[index]['userDetails'][1]['userId'].toString(),
                                            item[index]['userDetails'][1]['userName'],
                                            item[index]['fcmToken'],
                                          model.phone[index]
                                        ),
                                        child: UserCard(
                                          image: model.avatar[index],
                                          name: item[index]['userDetails'][1]['userName'],
                                          lastMsg:item[index]['lastMessage'],
                                          lastMsgTime: item[index]['lastModified'],
                                          newMsg:false,
                                        ),
                                      );
                                    },
                                  );
                          } else
                            return Container();
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
