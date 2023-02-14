import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget commonLoader() {
  return Container(
    height: Get.height,
    width: Get.width,
    alignment: Alignment.center,
    color: ColorRes.bgColor,
    child: Center(
        child: Container(
            height: 100,
            width: 100,
            child: Image.asset("assets/image/screenLoader.gif"))),
  );
}
