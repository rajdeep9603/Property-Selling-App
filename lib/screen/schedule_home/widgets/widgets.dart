import 'package:com.propacy.b2c/screen/personal_property_details/personal_property_details_screen.dart';
import 'package:com.propacy.b2c/screen/property_details/widgets/widget.dart';
import 'package:com.propacy.b2c/screen/schedule_home/schedule_home_screen.dart';
import 'package:com.propacy.b2c/screen/schedule_home/schedule_view_model.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_screen.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget priceDetailsBoxVisit() {
  return Container(
    width: Get.width,
    height: Get.height / 6,
    decoration: BoxDecoration(
      // color: ColorRes.raioContainer,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorRes.raioContainer),
    ),
    child: Column(
      children: [
        Container(
          width: Get.width,
          // height: Get.height/6,
          decoration: BoxDecoration(
            color: ColorRes.containerbgColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppRes.price,
                  style: AppTextStyle(
                      textColor: Colors.white,
                      size: 17,
                      weight: FontWeight.w500),
                ),
                SizedBox(height: 3),
                Text(
                  AppRes.subPrice,
                  style: AppTextStyle(
                      textColor: Colors.white,
                      size: 13,
                      weight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Get.to(()=>PersonalPropertyDetailsScreen());
            // Get.to(()=>PersonalPropertyDetailsScreen());
            Get.off(() => ShortListScreen());
          },
          child: Container(
            width: Get.width,
            // height: Get.height/6,
            color: ColorRes.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(Icons.calculate,color: ColorRes.white,size: 30,),
                    Text(
                      AppRes.scheduleVisit,
                      style: AppTextStyle(
                          textColor: Colors.white,
                          size: 17,
                          weight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget bottembarSchedule(ScheduleViewModel model) {
  return Container(
    height: Get.height / 12,
    width: Get.width,
    // height: ,
    color: ColorRes.raioContainer,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Spacer(),
          Expanded(
            child: InkWell(
              onTap: () {
                model.notifyListeners();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                // width: Get.width/2,
                height: 40,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color(0xFF444A61),
                        child: Icon(Icons.clear)),
                    SizedBox(width: 10),
                    CircleAvatar(
                        backgroundColor: Color(0xFF444A61),
                        child: Icon(Icons.map_outlined)),
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   width: 2,
          //   height: 50,
          //   color: ColorRes.containerbgColor,
          // ),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.to(() => ScheduleHomeScreen());
              },
              child: Container(
                height: Get.height / 20,
                decoration: BoxDecoration(
                  color: ColorRes.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/icons/bottem1.png",
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                      width: 20,
                      height: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      AppRes.shedule,
                      style: AppTextStyle(
                          textColor: ColorRes.white,
                          weight: FontWeight.bold,
                          size: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Spacer(),
        ],
      ),
    ),
  );
}

Widget appBarSchedule() {
  return Container(
    width: Get.width,
    height: Get.height / 15,
    color: ColorRes.black,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              child: Image.asset(
                "assets/icons/cross.png",
                color: Colors.white,
                fit: BoxFit.fill,
              ),
              width: 15,
              height: 15,
            ),
          ),
          Row(
            children: [
              SizedBox(width: Get.width / 8),
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/image/propertyHome.png",
                      fit: BoxFit.fill,
                    )),
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/image/propertyHome.png",
                      fit: BoxFit.fill,
                    )),
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/image/propertyHome.png",
                      fit: BoxFit.fill,
                    )),
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Image.asset(
                  "assets/icons/sharenew.png",
                  color: Colors.white,
                  fit: BoxFit.fill,
                ),
                width: 15,
                height: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                AppRes.share,
                style: AppTextStyle(
                    textColor: ColorRes.white,
                    weight: FontWeight.bold,
                    size: 15),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget middlePartSchedule() {
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "3 bhk.1120 area.Patel Street,Jogeshvari",
            style: AppTextStyle(
                textColor: Colors.white, size: 17, weight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          floorTitleBox(),
          SizedBox(height: Get.height / 40),
          priceDetailsBoxVisit(),
        ],
      ),
    ),
  );
}

Widget listViewTabbarSchedule(ScheduleViewModel model) {
  return Container(
    width: Get.width,
    height: Get.height / 15,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: model.tabbarList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              model.tabTitle = model.tabbarList[index].toString();
              model.notifyListeners();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              width: Get.width / 3,
              // height: Get.,
              decoration: model.tabTitle == model.tabbarList[index].toString()
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorRes.raioContainer,
                    )
                  : BoxDecoration(),
              child: Text(
                model.tabbarList[index].toString(),
                style: AppTextStyle(textColor: ColorRes.white),
              ),
            ),
          );
        }),
  );
}

Widget listViewBuilder(ScheduleViewModel model) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    width: Get.width,
    height: Get.height / 3,
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: model.tabbarListTitle.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              // alignment: Alignment.center,
              width: Get.width / 6,
              height: Get.height / 12,
              // height: Get.,
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Get.width / 2.5,
                        height: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: ColorRes.white,
                                  size: 30,
                                ),
                                Text(
                                  model.tabbarListTitle[index].toString(),
                                  style:
                                      AppTextStyle(textColor: ColorRes.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 15,
                      ),
                      Container(
                        width: Get.width / 10,
                        height: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.tabbarListSubtitle[index].toString(),
                              style: AppTextStyle(textColor: ColorRes.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 2,
                    width: Get.width,
                    color: ColorRes.raioContainer,
                  ),
                ],
              ),
            ),
          );
        }),
  );
}
