import 'dart:async';

import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onMsgSnd;
  final Function(String? value) onChange;
  final bool showBtnColor;
  final ScrollController? scrollController;

  BottomInputBar(
      {Key? key,
      required this.controller,
      required this.onMsgSnd,
      required this.onChange,
      required this.showBtnColor,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: ColorRes.darkBlue2,
      padding: EdgeInsets.fromLTRB(11, 10, 11, 9),
      child: SafeArea(
        top: false,
        child: Container(
          //height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 6, 0),
          decoration: BoxDecoration(
            color: ColorRes.divider,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  onTap: () {
                    Timer(
                        Duration(milliseconds: 300),
                        () => scrollController!.jumpTo(
                            scrollController!.position.maxScrollExtent));
                  },
                  controller: controller,
                  onChanged: onChange,
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 14,
                  ),
                  maxLines: 8,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 0, left: 15, top: 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.5),
                child: InkWell(
                  onTap: onMsgSnd,
                  borderRadius: BorderRadius.circular(35),
                  child: Container(
                    height: 37,
                    width: 37,
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: showBtnColor
                          ? ColorRes.primaryBlue
                          : ColorRes.darkBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AssetRes.arrowUp,
                      color: showBtnColor ? ColorRes.black : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
