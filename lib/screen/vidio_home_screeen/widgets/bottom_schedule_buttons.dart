import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/screen/property_details/widgets/widget.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

DateTime? selectedDateVideo = DateTime.now();

class BottomScheduleButtons extends StatelessWidget {
  final VoidCallback onShortListBtnTap;
  final VoidCallback onDateSelect;
  final VoidCallback onDateUpdate;
  final ArrMatch arrMatch;
  int index = 0;
  final _controller = CupertinoDatePickerController();
  final String PID;

  BottomScheduleButtons({
    Key? key,
    required this.onShortListBtnTap,
    required this.arrMatch,
    required this.onDateSelect,
    required this.onDateUpdate,
    required this.PID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (arrMatch.tourType == 'physicaltour') {
      return datePickerBtn(context);
    }

    if (arrMatch.shortList == true) {
      print("PID : $PID");
      print("SHORT LIST TAP");
      return unSaveNVisitBtn(context);
    }

    return shortListBtn();
  }

  Widget shortListBtn() {
    //shortlist button
    return GestureDetector(
      onTap: onShortListBtnTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        width: Get.width,
        height: Get.height / 18,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorRes.btnBg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 18,
              child: Image.asset(
                "assets/icons/save.png",
                color: ColorRes.btnBg,
              ),
            ),
            // Icon(Icons.save_alt, color: Color(0xFF76CCDD)),
            Text(
              "Shortlist",
              style: AppTextStyle(
                  textColor: ColorRes.btnBg, size: 16, weight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget unSaveNVisitBtn(context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print("TAPPEd");
            },
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 5),
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
                  color: ColorRes.containerbgColor,
                )*/
                ,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          InkWell(
            onTap: () {
              print("SCHEDULE VISIT TAP");
              FirebaseAnalyticsService.sendAnalyticsEvent3(
                  Str.cSchedule, Str.click, Str.lSchedule_page,PID);
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
                                                selectedDateVideo!.subtract(
                                                    Duration(days: 7)));
                                          } else {
                                            _controller.scrollToDate(
                                                selectedDateVideo!
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
                                                selectedDateVideo!.subtract(
                                                    Duration(days: 21)));
                                          } else {
                                            _controller.scrollToDate(
                                                selectedDateVideo!
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
                                //date picker
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
                                      if (value != selectedDateVideo)
                                        setState(() {
                                          selectedDateVideo = value;
                                          print(
                                              "=============>>>>>>>>>>>>>$selectedDateVideo");
                                        });
                                    },
                                    minuteInterval: 30,
                                    initialDateTime: initialDate,
                                    minimumYear: 2019,
                                    maximumYear: 2021,
                                  ),
                                ),
                              ),
                              InkWell(
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
              width: Get.width - 123,
              decoration: BoxDecoration(
                color: ColorRes.black.withOpacity(0.6),
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
    );
  }

  Widget datePickerBtn(context) {
    String date = DateFormat('dd, EE for hh a').format(arrMatch.dtmSchedule!);
    return InkWell(
      onTap: () {
        FirebaseAnalyticsService.sendAnalyticsEvent3(
            Str.cSchedule, Str.click, Str.lSchedule_page,PID);
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
                                  _controller.scrollToDate(DateTime.now());
                                });
                              },
                              child: Container(
                                decoration: index == 0
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
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
                                          selectedDateVideo!
                                              .subtract(Duration(days: 7)));
                                    } else {
                                      _controller.scrollToDate(
                                          selectedDateVideo!
                                              .add(Duration(days: 7)));
                                    }
                                    index = 1;
                                  });
                                }
                              },
                              child: Container(
                                decoration: index == 1
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
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
                                          selectedDateVideo!
                                              .subtract(Duration(days: 21)));
                                    } else {
                                      _controller.scrollToDate(
                                          selectedDateVideo!
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
                                        borderRadius: BorderRadius.circular(50),
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
                              initialDateTime: (arrMatch == null ||
                                      arrMatch.dtmSchedule == null)
                                  ? initialDate/*DateTime.now()*/
                                  : arrMatch.dtmSchedule,
                              onDateTimeChanged: (value) {
                                if (value != selectedDateVideo)
                                  setState(() {
                                    selectedDateVideo = value;
                                    print(
                                        "=============>>>>>>>>>>>>>$selectedDateVideo");
                                  });
                              },
                              // initialDateTime: selectedDate,
                              minuteInterval: 30,
                              minimumYear: 2019,
                              maximumYear: 2021,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onDateUpdate,
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
                                      textColor: ColorRes.containerbgColor,
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
        margin: EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        height: 50,
        width: Get.width - 48,
        decoration: BoxDecoration(
          color: ColorRes.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: Color(0xFF76CCDD), width: 1.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_walk_outlined, color: Color(0xFF76CCDD)),
            SizedBox(width: 10),
            Text(
              "Visit: $date",
              style: AppTextStyle(
                  textColor: Color(0xFF76CCDD),
                  size: 14,
                  weight: FontWeight.bold),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
