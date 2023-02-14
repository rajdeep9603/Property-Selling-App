import 'dart:async';

import 'package:com.propacy.b2c/screen/chat/chat_screen/chat_screen_view_model.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MessageBox extends StatelessWidget {
  final String message;
  final String time;
  final bool leftSide;
  final String type;

  const MessageBox({
    Key? key,
    required this.message,
    required this.time,
    required this.leftSide,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Timer(
    //     Duration(milliseconds: 300),
    //         () => scrollController!.jumpTo(
    //         scrollController!.position.maxScrollExtent));
    return Row(
      mainAxisAlignment:
          leftSide ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [leftSide ? anotherUserMsg() : currentUserMsg()],
    );
  }

  Widget anotherUserMsg() {
    Size? size;
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorRes.raioContainer,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AssetRes.userProfile,
            height: 16,
            width: 14,
            color: ColorRes.primaryBlue,
          ),
          SizedBox(width: 12),
          Container(
            width: 2,
            //height: size != null ? size.height : 0,
            height: 17,
            color: ColorRes.primaryBlue,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: Get.width / 4,
                  maxWidth: Get.width / 1.7,
                ),
                child: Text(
                  message,
                  style: TextStyle(color: ColorRes.white2),
                ),
              ),
              SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  fontSize: 10,
                  color: ColorRes.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget currentUserMsg() {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorRes.raioContainer,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: Get.width / 4,
                  maxWidth: Get.width / 1.7,
                ),
                child: Text(
                  message,
                  style: TextStyle(color: ColorRes.white2),
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Image.asset(
                    AssetRes.doubleTick,
                    height: 14,
                    width: 14,
                  ),
                  SizedBox(width: 6),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 10,
                      color: ColorRes.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 12),
          Container(
            width: 2,
            height: 25,
            color: ColorRes.textGrey,
          ),
          SizedBox(width: 12),
          Column(
            children: [
              Image.asset(
                AssetRes.userProfile2,
                width: 14,
                height: 16,
              ),
              SizedBox(height: 2),
              Text(
                "ME",
                style: TextStyle(
                  fontSize: 8,
                  color: ColorRes.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
