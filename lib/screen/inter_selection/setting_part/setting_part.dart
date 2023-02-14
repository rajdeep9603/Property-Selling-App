import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/setting_part/support_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/setting_part/terms_and_condition_screen.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_textstyle.dart';
import 'package:com.propacy.b2c/utils/common_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPart {
  static void _launchURL() async {
    if (!await launch("https://propacy.com/pages/tnc.html"))
      throw 'Could not launch ://propacy.com/pages/tnc.html';
  }

  static void _launchURLSupport() async {
    if (!await launch("https://propacy.com/pages/support.html"))
      throw 'Could not launch ://https://propacy.com/pages/support.html';
  }

  static settingSection() {
    return Padding(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Container(
          height: Get.height * 0.4,
          width: Get.width,
          decoration: BoxDecoration(
            // border: Border.all(color: ColorRes.yellow),
            color: ColorRes.bgColor,
          ),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.topLeft,
                  child: Text(AppRes.settings, style: settingTextStyle)),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ThisWebViewScreen(passUrl: AppRes.termsUrl,));
                  // _launchURL();
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.white)
                  // ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        AssetRes.terms,
                        color: ColorRes.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppRes.termsAndCondition,
                        style: subtitleSettingTextStyle,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        color: ColorRes.white2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ThisWebViewScreen(passUrl: AppRes.supportUrl,));
                  // _launchURLSupport();
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.white)
                  // ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        AssetRes.support,
                        color: ColorRes.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppRes.support,
                        style: subtitleSettingTextStyle,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        color: ColorRes.white2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // logout();
                  logOutDialog();
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white)
                      ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        AssetRes.logout,
                        color: ColorRes.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppRes.logout,
                        style: subtitleSettingTextStyle,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        color: ColorRes.white2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
