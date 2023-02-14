import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_splash/vidio_splash_screen.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

Widget forYouTab(model, PostPreferenceModel feedmodel, BuildContext context) {
  return Column(
    children: [
      Container(
        width: Get.width,
        height: Get.height / 11,
        color: Color(0xFF1A2331),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 9),
            InkWell(
              onTap: () {
                model.selectedTab = AppRes.foryou;
                model.notifyListeners();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                width: Get.width / 5 + 10,
                height: 33,
                child: Text(
                  AppRes.foryou,
                  style: model.selectedTab == AppRes.foryou
                      ? AppTextStyle(
                          textColor: ColorRes.white,
                          size: 16,
                          weight: FontWeight.w600)
                      : AppTextStyle(
                          size: 16,
                          textColor: ColorRes.radio,
                          weight: FontWeight.w600),
                ),
                decoration: model.selectedTab == AppRes.foryou
                    ? BoxDecoration(
                        color: ColorRes.raioContainer,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorRes.white),
                      )
                    : BoxDecoration(),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                model.selectedTab = AppRes.explore;
                model.notifyListeners();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                width: Get.width / 5 + 10,
                height: 33,
                decoration: model.selectedTab == AppRes.explore
                    ? BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorRes.white),
                      )
                    : BoxDecoration(),
                child: Text(
                  AppRes.explore,
                  style: model.selectedTab == AppRes.explore
                      ? AppTextStyle(
                          textColor: ColorRes.white,
                          size: 16,
                          weight: FontWeight.w600)
                      : AppTextStyle(
                          size: 16,
                          textColor: ColorRes.radio,
                          weight: FontWeight.w600),
                ),
              ),
            ),
            Spacer(
              flex: 4,
            ),
            Container(
              child: Image.asset(AssetRes.chat, color: Colors.white),
              width: 30,
              height: 30,
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          width: Get.width,
          height: Get.height / 2,
          decoration: BoxDecoration(
            color: ColorRes.containerbgColor,
            border: Border(
              top: BorderSide(width: 0.0, color: Color(0xFF1A2331)),
              bottom: BorderSide(
                  width: 2.0, color: ColorRes.raioContainer.withOpacity(0.5)),
            ),
          ),
          child: Image.asset("assets/image/foryouImage.png"),
        ),
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: ColorRes.containerbgColor,
            border: Border(
              top: BorderSide(width: 0.0, color: Color(0xFF1A2331)),
              bottom: BorderSide(
                  width: 2.0, color: ColorRes.raioContainer.withOpacity(0.5)),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 30,
                ),
                SvgPicture.asset(
                  'assets/icons/homeMain.svg',
                  color: Colors.white,
                  width: 50.0,
                  height: 50.0,
                ),
                SizedBox(
                  height: Get.height / 30,
                ),
                Center(
                    child: Text(
                  AppRes.welcomePropacy,
                  style: AppTextStyle(
                      textColor: ColorRes.white,
                      size: 16,
                      weight: FontWeight.bold),
                )),
                SizedBox(
                  height: Get.height / 30,
                ),
                Text(
                  AppRes.welcomePropacySubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle(
                      textColor: ColorRes.textGrey,
                      size: 16,
                      weight: FontWeight.bold),
                ),
                SizedBox(
                  height: Get.height / 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.red,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Get.to(()=>VidioScreen(feedModel:feedmodel));
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: VidioScreen(
                                    feedModel:
                                        feedmodel == null ? null : feedmodel)));
                        // Get.to(()=>ExploreVidioScreen());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: Get.height / 15,
                        decoration: BoxDecoration(
                          color: ColorRes.btnBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorRes.btnBg),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              AppRes.getStarted,
                              style: AppTextStyle(
                                  textColor: ColorRes.black,
                                  size: 16,
                                  weight: FontWeight.w600),
                            ),
                            Icon(Icons.arrow_forward, color: ColorRes.black),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 50 + 3,
                ),
                Divider(
                  color: ColorRes.raioContainer,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
