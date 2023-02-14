import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton {
  static myButton(String text) {
    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.only(top: 15, right: 10, left: 10),
      height: Get.height / 15,
      width: Get.width - 20,
      decoration: BoxDecoration(
          // border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: ColorRes.btnBg),
      child: Text(
        text,
        style: AppTextStyle(
            textColor: ColorRes.darkBlue, size: 16, weight: FontWeight.w600),
      ),
    );
  }
}
