import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void appBackAlert() {
  Get.dialog(
    AlertDialog(
      title: Text(
        "Exit app".tr,
        style: AppTextStyle(textColor: ColorRes.black, size: 20),
      ),
      content: Text(
        "Are you want to sure exit?".tr,
        style: AppTextStyle(textColor: ColorRes.black, size: 17),
      ),
      actions: [
        RaisedButton(
          color: Colors.red,
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text(
            "yes".tr,
            style: AppTextStyle(textColor: ColorRes.white),
          ),
        ),
        RaisedButton(
          color: ColorRes.green,
          onPressed: () {
            Get.back();
          },
          child: Text(
            "no".tr,
            style: AppTextStyle(textColor: ColorRes.white),
          ),
        ),
      ],
    ),
  );
}

void logOutDialog() {
  Get.dialog(
    AlertDialog(
      // title: Text(
      //   "Exit app".tr,
      //   style: AppTextStyle(textColor: ColorRes.black, size: 20),
      // ),
      content: Text(
        "Do you want to logout?".tr,
        style: AppTextStyle(textColor: ColorRes.black, size: 17),
      ),
      actions: [
        RaisedButton(
          color: Colors.red,
          onPressed: () {
            logout();
          },
          child: Text(
            "yes".tr,
            style: AppTextStyle(textColor: ColorRes.white),
          ),
        ),
        RaisedButton(
          color: ColorRes.green,
          onPressed: () {
            Get.back();
          },
          child: Text(
            "no".tr,
            style: AppTextStyle(textColor: ColorRes.white),
          ),
        ),
      ],
    ),
  );
}
