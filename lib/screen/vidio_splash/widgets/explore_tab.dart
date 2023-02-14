import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget exploreTabScreen(model, PostPreferenceModel feedmodel) {
  return Stack(
    children: [
      Container(
        width: Get.width,
        height: Get.height,
        child: Image.asset(
          "assets/image/vidioBg.png",
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
          child: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.black.withOpacity(0.85),
      )),
      Positioned(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 3),
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
                                textColor: ColorRes.radio,
                                size: 16,
                                weight: FontWeight.w600),
                      ),
                      decoration: model.selectedTab == AppRes.foryou
                          ? BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
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
                        style: AppTextStyle(
                            textColor: ColorRes.white,
                            size: 16,
                            weight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(AssetRes.chat, color: Colors.white)),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: Get.height / 20,
              ),
              Center(
                  child: Text(
                AppRes.splashTitle,
                style: AppTextStyle(
                    textColor: ColorRes.white,
                    size: 20,
                    weight: FontWeight.w600),
              )),
              SizedBox(
                height: Get.height / 7,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/image/swipeleft.png"),
                          SizedBox(width: 10),
                          Text(
                            AppRes.swipeLeft,
                            style: AppTextStyle(
                                textColor: ColorRes.white,
                                size: 20,
                                weight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 4,
                      //       height: 4,
                      //       color: Colors.white,
                      //     ),
                      //   ],
                      // ),

                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: 200,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.white,
                        // dashGradient: [Colors.red, Colors.blue],
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        // dashGapColor: Colors.transparent,
                        // dashGapGradient: [Colors.red, Colors.blue],
                        dashGapRadius: 0.0,
                      ),
                    ],
                  )),

              SizedBox(
                height: Get.height / 6,
              ),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/image/swipeup.png"),
                          SizedBox(width: 10),
                          Text(
                            AppRes.swipeUp,
                            style: AppTextStyle(
                                textColor: ColorRes.white,
                                size: 20,
                                weight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: 250,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.white,
                        // dashGradient: [Colors.red, Colors.blue],
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        // dashGapColor: Colors.transparent,
                        // dashGapGradient: [Colors.red, Colors.blue],
                        dashGapRadius: 0.0,
                      ),
                    ],
                  )),
              SizedBox(
                height: Get.height / 8,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => VidioScreen(
                        feedModel: feedmodel == null ? null : feedmodel,
                      ));
                  // Get.to(()=>ExploreVidioScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width,
                  height: Get.height / 16,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorRes.btnBg),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: ColorRes.btnBg),
                      SizedBox(width: 10),
                      Text(
                        AppRes.gotit,
                        style: AppTextStyle(
                            textColor: ColorRes.btnBg,
                            size: 16,
                            weight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: ColorRes.raioContainer,
                thickness: 1,
              ),
              // SizedBox(height: Get.height/60,),
            ],
          ),
        ),
      )),
      Positioned(
          left: Get.width * 0.41 + 1,
          top: Get.height * 0.34 - 2,
          child: Image.asset(
            "assets/image/swipeleftarrow.png",
            color: ColorRes.white,
          )),
      Positioned(
          left: Get.width * 0.03,
          top: Get.height * 0.59,
          child: Image.asset(
            "assets/image/swipeuparrow.png",
            color: ColorRes.white,
          )),
    ],
  );
}
