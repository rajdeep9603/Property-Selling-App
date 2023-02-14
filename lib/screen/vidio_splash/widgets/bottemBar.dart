import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/vidio_view_model.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottemBar() {
  return Container(
    width: Get.width,
    color: ColorRes.containerbgColor,
    child: Padding(
      // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 5),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Spacer(),
          Container(
            child: Image.asset("assets/image/homenavigation.png"),
          ),
          Spacer(),
          Container(
            child: Image.asset("assets/image/savenavigation.png"),
          ),
          Spacer(),
          GestureDetector(
            child: Container(
              child: Image.asset("assets/image/profilenavigation.png"),
            ),
          ),
          // Spacer(),
        ],
      ),
    ),
  );
}
