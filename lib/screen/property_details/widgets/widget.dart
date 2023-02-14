import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/screen/property_details/property_details_view_model.dart';
import 'package:com.propacy.b2c/screen/property_details/widgets/photo_zoom_In_out.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_screen.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

DateTime? selectedDateTime = DateTime.now();
// final _controller = CupertinoDatePickerController();
bool? scheVisitap = false;

Widget bottemBarNew(
  PropertyDetailsViewModel model,
  BuildContext context,
  DateTime? datetime,
  VoidCallback onDateSelect,
    String? pId
) {
  int index = 0;

  final _controller = CupertinoDatePickerController();
  // final _controller = CupertinoDatePickerController();
  return Container(
    width: Get.width,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print("TAPPEd");
              /*isShortListed = false;
              model.onShortlistCalled(
                  date: selectedDateTime!
                      .toIso8601String(),
                  status: 'I');
              model.notifyListeners();*/
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              height: 50,
              width: 65,
              decoration: BoxDecoration(
                color: Color(0xFF76CCDD),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: Color(0xFF76CCDD), width: 1.7),
              ),
              child: Center(
                child: Container(
                    height: 40,
                    width: 25,
                    child: Image.asset(
                      "assets/icons/save.png",
                      color: ColorRes.containerbgColor,
                    )) /*Icon(
                  Icons.bookmark_border,
                  color: ColorRes.black,
                )*/
                ,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          InkWell(
            onTap: () {
              print("SCHEDULE VISIT TAP FROM PROPERTY DETAILS");
              FirebaseAnalyticsService.sendAnalyticsEvent3(
                  Str.cSchedule, Str.click, Str.lSchedule_page,pId);
              double heightOfModalBottomSheet = 100;
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    final minDate = DateTime.now();
                    final difference = 30 - minDate.minute % 30;
                    final initialDate = minDate.add(Duration(minutes: difference));
                    return StatefulBuilder(
                      builder: (context, setState) => Container(
                          height: Get.height / 1.2,
                          color: ColorRes.containerbgColor,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 0.0,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Pick a time slot of your choice',
                                  style: AppTextStyle(
                                      textColor: ColorRes.textGrey,
                                      size: 14,
                                      weight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index = 0;
                                        _controller
                                            .scrollToDate(DateTime.now());
                                      });
                                    },
                                    child: Container(
                                      decoration: index == 0
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorRes.raioContainer,
                                              border: Border.all(
                                                width: 2.0,
                                                color: ColorRes.grey,
                                              ),
                                            )
                                          : BoxDecoration(),
                                      height: 35,
                                      width: Get.width / 3.5,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "This week",
                                        style: AppTextStyle(
                                          textColor: ColorRes.whiteText,
                                          size: 14,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  GestureDetector(
                                    onTap: () {
                                      if (index != 1) {
                                        setState(() {
                                          if (index == 2) {
                                            _controller.scrollToDate(
                                                selectedDateTime!.subtract(
                                                    Duration(days: 7)));
                                          } else {
                                            _controller.scrollToDate(
                                                selectedDateTime!
                                                    .add(Duration(days: 7)));
                                          }
                                          index = 1;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: index == 1
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorRes.raioContainer,
                                              border: Border.all(
                                                width: 2.0,
                                                color: ColorRes.grey,
                                              ),
                                            )
                                          : BoxDecoration(),
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: Get.width / 3.5,
                                      child: Text(
                                        "Next week",
                                        style: AppTextStyle(
                                          textColor: ColorRes.whiteText,
                                          size: 14,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  GestureDetector(
                                    onTap: () {
                                      if (index != 2) {
                                        setState(() {
                                          if (index == 2) {
                                            _controller.scrollToDate(
                                                selectedDateTime!.subtract(
                                                    Duration(days: 21)));
                                          } else {
                                            _controller.scrollToDate(
                                                selectedDateTime!
                                                    .add(Duration(days: 21)));
                                          }
                                        });
                                        index = 2;
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: index == 2
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorRes.raioContainer,
                                              border: Border.all(
                                                width: 2.0,
                                                color: ColorRes.grey,
                                              ),
                                            )
                                          : BoxDecoration(),
                                      height: 35,
                                      width: Get.width / 3.5,
                                      child: Text(
                                        "+2 weeks",
                                        style: AppTextStyle(
                                          textColor: ColorRes.whiteText,
                                          size: 14,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: Get.height * 0.3,
                                child: CupertinoTheme(
                                  data: CupertinoThemeData(
                                    textTheme: CupertinoTextThemeData(
                                      dateTimePickerTextStyle: TextStyle(
                                        color: ColorRes.white,
                                      ),
                                    ),
                                  ),
                                  child: ControlledCupertinoDatePicker(
                                    controller: _controller,
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    minimumDate: DateTime.now(),
                                    onDateTimeChanged: (value) {
                                      if (value != selectedDateTime)
                                        setState(() {
                                          selectedDateTime = value;
                                          print(
                                              "=============>>>>>>>>>>>>>$selectedDateTime");
                                        });
                                    },
                                    initialDateTime: initialDate,
                                    minuteInterval: 30,
                                    minimumYear: 2019,
                                    maximumYear: 2021,
                                  ),
                                ),
                              ),
                              InkWell(
                                /*onTap: () {
                                  model.onShortlistCalled(
                                    date: selectedDateTime!
                                        .toIso8601String(),
                                    status: 'A',
                                  );
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) {
                                      return Container(
                                        height: 270,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 15,
                                        ),
                                        color: ColorRes.containerbgColor,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Visit scheduled successfully!",
                                                  style: AppTextStyle(
                                                      textColor:
                                                          ColorRes.textGrey,
                                                      size: 16,
                                                      weight: FontWeight.bold),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                    onTap: () => Get.back(),
                                                    child: Image.asset(
                                                        "assets/icons/editblue.png")),
                                                SizedBox(width: 10.0),
                                                Text(
                                                  "Edit",
                                                  style: AppTextStyle(
                                                    textColor:
                                                        ColorRes.primaryBlue,
                                                    size: 16,
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 15.0),
                                              ],
                                            ),
                                            SizedBox(width: 12.0),
                                            Image.asset(
                                              "assets/icons/caltrue.png",
                                              height: 80.0,
                                              width: 80.0,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Text(
                                                "We have sent you confirmation details over SMS and a calendar invite on your email",
                                                style: AppTextStyle(
                                                  textColor: ColorRes.white,
                                                  size: 16,
                                                  weight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 15.0),
                                            InkWell(
                                              onTap: () {
                                                print("================>selected : $selectedDateTime");
                                                model.onShortlistCalled(
                                                    date: selectedDateTime!
                                                        .toIso8601String(),
                                                status: 'A',
                                                );
                                                Get.back();
                                                Get.back();
                                                Get.to(() => ShortListScreen());
                                                model.isVisitScheduled = true;
                                                setState(() {});
                                                model.notifyListeners();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                alignment: Alignment.center,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF76CCDD),
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                  border: Border.all(
                                                    color: Color(0xFF76CCDD),
                                                    width: 1.7,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Got it",
                                                  style: AppTextStyle(
                                                    textColor: ColorRes
                                                        .containerbgColor,
                                                    size: 16,
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },*/
                                onTap: onDateSelect,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  alignment: Alignment.center,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF76CCDD),
                                    borderRadius: BorderRadius.circular(99),
                                    border: Border.all(
                                        color: Color(0xFF76CCDD), width: 1.7),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.directions_walk_outlined,
                                          color: Color(0xFF76CCDD)),
                                      SizedBox(width: 10),
                                      Text(
                                        "Done",
                                        style: AppTextStyle(
                                            textColor:
                                                ColorRes.containerbgColor,
                                            size: 16,
                                            weight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                    // return BottomSheetBox(model: PropertyDetailsViewModel());
                  });
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: Get.width - 130,
              decoration: BoxDecoration(
                color: ColorRes.containerbgColor,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: Color(0xFF76CCDD), width: 1.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_walk_outlined,
                      color: Color(0xFF76CCDD)),
                  SizedBox(width: 10),
                  Text(
                    "Schedule visit",
                    style: AppTextStyle(
                        textColor: Color(0xFF76CCDD),
                        size: 16,
                        weight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget floorTitleBox() {
  return Container(
    width: Get.width,
    height: Get.height / 11,
    decoration: BoxDecoration(
      color: ColorRes.raioContainer,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
        child: Text(
      AppRes.subtitlePropertyDetails,
      style: AppTextStyle(
          textColor: Colors.white, size: 17, weight: FontWeight.bold),
    )),
  );
}

Widget priceDetailsBox() {
  return Container(
    width: Get.width,
    height: Get.height / 6,
    decoration: BoxDecoration(
      color: ColorRes.raioContainer,
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
        Container(
          width: Get.width,
          // height: Get.height/6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calculate,
                    color: ColorRes.white,
                    size: 30,
                  ),
                  Text(
                    AppRes.Emical,
                    style: AppTextStyle(
                        textColor: Colors.white,
                        size: 17,
                        weight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget tabBarPropertyDetails() {
  return Container(
    width: Get.width,
    height: Get.height / 12,
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
                "assets/icons/back.png",
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

Widget imageSlider(List<dynamic>? images, List<dynamic>? galleryImgList) {
  return CarouselSlider(
      options: CarouselOptions(
        initialPage: 1,
        viewportFraction: 1,
      ),
      items: images!
          .asMap()
          .map((index, value) {
            return MapEntry(index, Builder(
              builder: (BuildContext context) {
                return Center(
                    child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        galleryImgList = images;
                        print("GalleryImgList" + galleryImgList.toString());
                        images!= null?
                        Get.to(
                          () => PhotoZoomInOut(
                              image: images[index].toString(),
                              images: galleryImgList),
                        )
                        : Get.to(
                              () => PhotoZoomInOut(
                              image: "assets/image/foryouImage.png",
                              images: ["assets/image/foryouImage.png"]),
                        );
                      },
                      child:images!= null? Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          "${images[index]}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ):Container(
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/image/foryouImage.png",
                          width: double.infinity,
                          color: ColorRes.raioContainer,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ColorRes.containerbgColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  child: Image.asset(
                                "assets/icons/propertyphoto.png",
                                height: 30,
                                width: 30,
                              )),
                              SizedBox(width: 5.0),
                              Text(
                                '${index + 1}' + '/' + "${images.length}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ],
                          )),
                    ),
                  ],
                ));
              },
            ));
          })
          .values
          .toList());
}

Widget endPartPropertyDetails({
  bool? showShortList,
  DateTime? dateTime,
  String? title,
  String? bedroom,
  String? subCity,
  String? city,
  String? sellingPoint,
  String? area,
  String? floor,
  String? description,
  PropertyDetailsViewModel? model,
  VoidCallback? onShortListChange,
}) {
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
                child: Image.asset("assets/icons/Price.png"),
              ),
              Text(
                model!.min.toString(),
                style: AppTextStyle(
                    textColor: ColorRes.white,
                    weight: FontWeight.bold,
                    size: 20),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "$title",
            style: AppTextStyle(
                textColor: Colors.white, size: 20, weight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "${bedroom}" +
                " bhk \u2022"
                    /*   " ${floor}" +
                " floor,"*/
                    "  ${area}" +
                " sq.ft. \u2022" +
                " ${subCity}",
            // "${bedroom}"+"BHK" + "${floor}" \u2022 $area \u2022 $sellingPoint, $subCity ",
            style: AppTextStyle(
                textColor: Colors.white, size: 16, weight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Divider(color: ColorRes.darkBlue, thickness: 2.1),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                child: Image.asset(
                  "assets/icons/write.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 5),
              Text(
                AppRes.propertyheighlight,
                style: AppTextStyle(
                    textColor: ColorRes.yellow,
                    weight: FontWeight.bold,
                    size: 15),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description!,
            style: AppTextStyle(
                textColor: Colors.white, size: 17, weight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          showShortList != true
              ? Container(height: 0, width: 0)
              : GestureDetector(
                  onTap: () {
                    /*showShortList = true;
                    model!.notifyListeners();
                    Get.to(() => ShortListScreen())!.then((value){
                      model.notifyListeners();
                    });*/
                    onShortListChange!();
                    /*model.onShortlistCalled(
                         // date: "2021-09-14T05:24:07.576Z",
                          date: "$selectedDateTime",
                      status: isShortListed ==  false ? "A" : "I"
                  );*/
                  },
                  // onTap: () => model.onShortlistCalled(
                  //   date: "2021-09-14T05:24:07.576Z",
                  // ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorRes.containerbgColor,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: ColorRes.btnBg, width: 1.7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 30,
                            width: 20,
                            child: Image.asset(
                              "assets/icons/save.png",
                              color: ColorRes.btnBg,
                            )),
                        SizedBox(width: 5),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            AppRes.shortlist,
                            style: AppTextStyle(
                                textColor: ColorRes.btnBg,
                                size: 16,
                                weight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

          // floorTitleBox(),
          SizedBox(height: Get.height / 40),
          // priceDetailsBox(),
        ],
      ),
    ),
  );
}

Widget chatIcon() {
  return Container(
    width: 40.0,
    height: 40.0,
    padding: EdgeInsets.only(
      right: 10.0,
    ),
    // color: Colors.red,
    alignment: Alignment.center,
    child: Stack(
      children: <Widget>[
        Container(
          height: 30,
          width: 25,
          // margin: EdgeInsets.all(2),
          child: Image.asset(
            "assets/icons/pencil.png",
          ),
        ),
        /* Positioned(
          right: 0,
          child: new Container(
            padding: EdgeInsets.all(1),
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: new Text(
              '1',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),*/
      ],
    ),
  );
}

Widget tabBar(String? title) {
  return Container(
    alignment: Alignment.center,
    height: 40,
    child: Text(
      title!,
      style: AppTextStyle(textColor: ColorRes.white, size: 14),
    ),
  );
}

Widget listViewTabbarSchedule(PropertyDetailsViewModel model) {
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

Widget listViewBuilder({
  List<String>? nearByAmenities,
  List<String>? valueList,
  PropertyDetailsViewModel? model,
  String? type,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: nearByAmenities!.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 55,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: Get.width / 2.5 + 20,
                      height: 40,
                      child: Row(
                        children: [
                          Image.asset(
                            imageString(nearByAmenities[index]),
                            color: ColorRes.white,
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            nearByAmenities[index].toString(),
                            style: AppTextStyle(textColor: ColorRes.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width / 15),
                    Container(
                      width: Get.width / 3,
                      height: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type == "nearby"
                                ? ""/*"2 km"*/
                                : type == "Amenities"
                                    ? ""
                                    : valueList![
                                        index] /*model!.tabbarListSubtitle[index]
                                        .toString()*/
                            ,
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
          );
        }),
  );
}

Widget visitScheduled(PropertyDetailsViewModel model, BuildContext context,
    VoidCallback onEditTap) {
  int index = 0;

  final _controller = CupertinoDatePickerController();
  return Container(
    height: 100.0,
    color: ColorRes.raioContainer,
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visit scheduled:",
                    style: AppTextStyle(
                      textColor: ColorRes.primaryBlue,
                      size: 16,
                      weight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    //selectedDateTime != null ? "${selectedDateTime!.day.toString()+" - " + selectedDateTime!.month.toString()+" - "+selectedDateTime!.year.toString()}" : "13, Mon for 1-2 PM",
                    selectedDateTime != null
                        ? DateFormat('dd-MM-yyyy hh:mm a')
                            .format(selectedDateTime!)
                        : "13",
                    style: AppTextStyle(
                        textColor: ColorRes.primaryBlue,
                        size: 17,
                        weight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: onEditTap,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                height: 50,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: ColorRes.btnBg, width: 1.7),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: ColorRes.primaryBlue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Edit",
                        style: AppTextStyle(
                            textColor: ColorRes.primaryBlue,
                            size: 17,
                            weight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

class CupertinoDatePickerController extends ChangeNotifier {
  List<_ScrollStateLinker> _linkers = [];

  void attach(_ScrollStateLinker linker) {
    assert(!_linkers.contains(linker));
    _linkers.add(linker);
    linker.addListener(notifyListeners);
  }

  void detach(_ScrollStateLinker linker) {
    assert(_linkers.contains(linker));
    _linkers.remove(linker);
    linker.removeListener(notifyListeners);
  }

  @override
  void dispose() {
    for (int i = 0; i < _linkers.length; i += 1) {
      _linkers[i].removeListener(notifyListeners);
    }
    super.dispose();
  }

  bool get hasClients => _linkers.isNotEmpty;

  DateTime get selectedDate {
    assert(_linkers.isNotEmpty,
        'CupertinoDatePickerController not attached to any views.');
    assert(_linkers.length == 1,
        'CupertinoDatePickerController attached to multiple views.');
    return _linkers.single.selectedDate;
  }

  Future<void> scrollToDate(DateTime newDate) {
    final futures = <Future<void>>[];
    for (int i = 0; i < _linkers.length; i += 1) {
      futures.add(_linkers[i].scrollToDate(newDate));
    }
    return Future.wait(futures);
  }

  _ScrollStateLinker _createScrollStateLinker(
      _ControlledCupertinoDatePickerState context) {
    return _ScrollStateLinker(context: context);
  }
}

// /////////////////////////////////////////////////////////////////////////////

class ControlledCupertinoDatePicker extends CupertinoDatePicker {
  ControlledCupertinoDatePicker({
    Key? key,
    this.controller,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.dateAndTime,
    ValueChanged<DateTime>? onDateTimeChanged,
    DateTime? initialDateTime,
    DateTime? minimumDate,
    DateTime? maximumDate,
    int minimumYear = 1,
    int? maximumYear,
    int minuteInterval = 1,
    bool use24hFormat = false,
    Color? backgroundColor,
  })  : assert(controller != null || onDateTimeChanged != null,
            'either a controller or onDateTimeChanged must be set'),
        super(
          key: key,
          mode: mode,
          onDateTimeChanged: onDateTimeChanged!,
          initialDateTime: initialDateTime,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
          minimumYear: minimumYear,
          maximumYear: maximumYear,
          minuteInterval: minuteInterval,
          use24hFormat: use24hFormat,
          backgroundColor: backgroundColor,
        );

  final CupertinoDatePickerController? controller;

  State<StatefulWidget> createState() => _ControlledCupertinoDatePickerState();
}

// /////////////////////////////////////////////////////////////////////////////

class _ControlledCupertinoDatePickerState
    extends State<ControlledCupertinoDatePicker> {
  GlobalKey _key = GlobalKey();
  _ScrollStateLinker? _linker;

  @override
  void initState() {
    super.initState();
    _linker = widget.controller?._createScrollStateLinker(this);
    widget.controller?.attach(_linker!);
  }

  @override
  void didUpdateWidget(ControlledCupertinoDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (_linker != null) oldWidget.controller?.detach(_linker!);
      _linker = widget.controller?._createScrollStateLinker(this);
      widget.controller?.attach(_linker!);
    }
  }

  @override
  void dispose() {
    if (_linker != null) {
      widget.controller?.detach(_linker!);
      _linker!.dispose();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      key: _key,
      mode: widget.mode,
      onDateTimeChanged: _onDateTimeChanged,
      initialDateTime: widget.initialDateTime,
      minimumDate: widget.minimumDate,
      maximumDate: widget.maximumDate,
      minimumYear: widget.minimumYear,
      maximumYear: widget.maximumYear,
      minuteInterval: widget.minuteInterval,
      use24hFormat: widget.use24hFormat,
      backgroundColor: widget.backgroundColor,
    );
  }

  DateTime get selectedDate {
    dynamic _state = _key.currentState as dynamic;
    switch (widget.mode) {
      case CupertinoDatePickerMode.date:
        return DateTime(
          _state.selectedYear as int,
          _state.selectedMonth as int,
          _state.selectedDay as int,
        );
      case CupertinoDatePickerMode.time:
      case CupertinoDatePickerMode.dateAndTime:
        return _state.selectedDateTime as DateTime;
    }
    return _state.selectedDateTime as DateTime;
  }

  Future<void> scrollToDate(DateTime newDate) {
    switch (widget.mode) {
      case CupertinoDatePickerMode.date:
        return _scrollToSafeDate(newDate);
        break;
      case CupertinoDatePickerMode.time:
      case CupertinoDatePickerMode.dateAndTime:
        return _scrollToSafeDateTime(newDate);
    }
    assert(false);
    return _scrollToSafeDateTime(newDate);
  }

  void _onDateTimeChanged(DateTime newDate) {
    widget.onDateTimeChanged.call(newDate);
    _linker?.didUpdateValue();
  }

  Future<void> _scrollToSafeDate(DateTime newDate) {
    final maxSelectDate = newDate.add(const Duration(days: 1));

    final minCheck = widget.minimumDate?.isBefore(maxSelectDate) ?? true;
    final maxCheck = widget.maximumDate?.isBefore(newDate) ?? false;

    if (!minCheck || maxCheck) {
      // We have minCheck === !maxCheck.
      final targetDate = minCheck ? widget.maximumDate : widget.minimumDate;
      return _scrollToDate(targetDate!);
    }

    return _scrollToDate(newDate);
  }

  Future<void> _scrollToDate(DateTime newDate) {
    assert(newDate != null);
    final completer = Completer<void>();
    SchedulerBinding.instance!.addPostFrameCallback((Duration timestamp) {
      dynamic _state = _key.currentState as dynamic;
      final futures = <Future<void>>[];

      if (_state.selectedYear != newDate.year) {
        futures.add(_animateColumnControllerToItem(
            _state.yearController, newDate.year));
      }

      if (_state.selectedMonth != newDate.month) {
        futures.add(_animateColumnControllerToItem(
            _state.monthController, newDate.month - 1));
      }

      if (_state.selectedDay != newDate.day) {
        futures.add(_animateColumnControllerToItem(
            _state.dayController, newDate.day - 1));
      }

      Future.wait(futures).whenComplete(completer.complete);
    });
    return completer.future;
  }

  Future<void> _scrollToSafeDateTime(DateTime newDate) {
    final minCheck = widget.minimumDate?.isAfter(newDate) ?? false;
    final maxCheck = widget.maximumDate?.isBefore(newDate) ?? false;

    if (minCheck || maxCheck) {
      // We have minCheck === !maxCheck.
      final targetDate = minCheck ? widget.minimumDate : widget.maximumDate;
      return _scrollToDateTime(targetDate!);
    }

    return _scrollToDateTime(newDate);
  }

  Future<void> _scrollToDateTime(DateTime newDate) {
    assert(newDate != null);
    final completer = Completer<void>();
    SchedulerBinding.instance!.addPostFrameCallback((Duration timestamp) {
      dynamic _state = _key.currentState as dynamic;
      final fromDate = _state.selectedDateTime as DateTime;
      final futures = <Future<void>>[];

      if (fromDate.year != newDate.year ||
          fromDate.month != newDate.month ||
          fromDate.day != newDate.day) {
        final diff = newDate.difference(widget.initialDateTime);
        futures.add(
            _animateColumnControllerToItem(_state.dateController, diff.inDays));
      }

      if (fromDate.hour != newDate.hour) {
        int i = 1;
        double nu = 10;
        final bool needsMeridiemChange =
            !widget.use24hFormat && fromDate.hour ~/ 12 != newDate.hour ~/ 12;
        // In AM/PM mode, the pickers should not scroll all the way to the other hour region.
        if (needsMeridiemChange) {
          futures.add(_animateColumnControllerToItem(
            _state.meridiemController,
            1 - int.parse(_state.meridiemController.selectedItem),
          ));

          // Keep the target item index in the current 12-h region.
          final int newItem = (_state.hourController.selectedItem ~/ 12) * 12 +
              (_state.hourController.selectedItem +
                      newDate.hour -
                      fromDate.hour) %
                  12;
          futures.add(
              _animateColumnControllerToItem(_state.hourController, newItem));
        } else {
          futures.add(_animateColumnControllerToItem(
            _state.hourController,
            _state.hourController.selectedItem + newDate.hour - fromDate.hour,
          ));
        }
      }

      if (fromDate.minute != newDate.minute) {
        futures.add(_animateColumnControllerToItem(
            _state.minuteController, newDate.minute));
      }

      Future.wait(futures).whenComplete(completer.complete);
    });
    return completer.future;
  }
}

Future<void> _animateColumnControllerToItem(
  FixedExtentScrollController controller,
  int targetItem,
) {
  return controller.animateToItem(
    targetItem,
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 200),
  );
}

class _ScrollStateLinker extends ChangeNotifier {
  _ScrollStateLinker({this.context});

  final _ControlledCupertinoDatePickerState? context;

  DateTime get selectedDate => context!.selectedDate;

  Future<void> scrollToDate(DateTime date) => context!.scrollToDate(date);

  void didUpdateValue() {
    notifyListeners();
  }
}
