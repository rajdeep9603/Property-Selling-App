import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget selectOtherPref() {
  return Container(
      height: Get.height,
      width: Get.width,
      color: ColorRes.containerbgColor,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            width: Get.width,
            height: Get.height / 2,
            decoration: BoxDecoration(
              color: ColorRes.containerbgColor,
              border: Border(
                top: BorderSide(width: 0.0, color: ColorRes.bgColor),
              ),
            ),
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                "assets/image/foryouImage.png",
              ),
            ),
          ),
          Container(
            height: 100,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            // decoration: BoxDecoration(
            //   border:Border.all(width: 2)
            // ),
            child: Column(
              children: [
                Text(
                  AppRes.aah,
                  style: AppTextStyle(
                      textColor: ColorRes.textGrey,
                      size: 14,
                      weight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  AppRes.ourTeam,
                  style: AppTextStyle(
                      textColor: ColorRes.textGrey,
                      size: 14,
                      weight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  AppRes.youMay,
                  style: AppTextStyle(
                      textColor: ColorRes.textGrey,
                      size: 14,
                      weight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ));
}
