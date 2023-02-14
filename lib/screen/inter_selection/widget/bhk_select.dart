import 'package:com.propacy.b2c/model/get_preference_model.dart';
import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/apartment_selection.dart';
import 'package:com.propacy.b2c/screen/search_area/search_select_area.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_textstyle.dart';
import 'package:com.propacy.b2c/utils/common_toast.dart';
import 'package:com.propacy.b2c/utils/custom_button.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BhkSelectScreen extends StatefulWidget {
  GetPreferenceModel? preferenceModel;

  BhkSelectScreen({this.preferenceModel});

  @override
  _BhkSelectScreenState createState() => _BhkSelectScreenState();
}

class _BhkSelectScreenState extends State<BhkSelectScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controllerBhk;
  bool animated = true;

  // List<bool> isChecked = List.generate(100, (index) => false);
  List<Group>? zoneExpansionList;
  List<String> tabList = ["anyZone", "south", "westurn", "central", "upper"];
  List<String> checkList = [
    "mahima to bandra ",
    "khar to andheri",
    "jogeshvari to borivali",
    "dahisar to virar",
    "palghar to beyond"
  ];

  // String title;
  List<bool>? checkBoolListSize = [];
  int categorySelected = 0;
  int checkArea = 0;
  bool zonesCome = false;
  bool? checkAreaTap = false;
  List<bool>? checkboolList;
  List<String>? homes;
  List<String>? tmpArray;

  @override
  void initState() {
    controllerBhk =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Future.delayed(100.milliseconds, () {
      setState(() {
        animated = false;
      });
    });
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.load, Str.lPreferences_bedroom_page);
  }

  // void initState() {}

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: (Get.height / 2 - 32) * 2,
      width: Get.width,
      alignment: animated ? Alignment.bottomCenter : Alignment.topCenter,
      child: Container(
        // duration: Duration(seconds: 3),
        // curve: Curves.easeInOut,
        // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        height: Get.height * 0.4 + 32,
        width: Get.width,
        color: ColorRes.containerbgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(AppRes.bhkTitle, style: titleBottomPartTextStyle),
                // SizedBox(
                //   height: 10,
                // ),
                // zonesCome == true ? checkMultipleArea(zoneExpansionList:zoneExpansionList) : Container(),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.white)
                  // ),
                  width: Get.width,
                  height: Get.height * 0.4 - 81,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:
                          widget.preferenceModel!.data!.bedrooms!.length == 0
                              ? 0
                              : widget.preferenceModel!.data!.bedrooms!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_bedroom_selected);
                            if (bedRoomMap[bedRoomList[index].toString()] ==
                                true) {
                              setState(() {
                                bedRoomMap[bedRoomList[index].toString()] =
                                    false;
                                for (var ele in bedRoomList) {
                                  if (bedRoomMap[ele] == true) {
                                    selectedbhk = ele.toString();
                                    break;
                                  } else {
                                    selectedbhk = "2";
                                  }
                                }
                                displayBedRooms
                                    .remove(bedRoomList[index].toString());
                              });
                            } else {
                              setState(() {
                                selectedbhk =
                                    "${widget.preferenceModel!.data!.bedrooms![index].toString()}";
                                bedRoomMap[bedRoomList[index].toString()] =
                                    true;
                                displayBedRooms
                                    .add(bedRoomList[index].toString());
                              });
                            }
                            print("AFTER CHANGE FURNISH TYPE====>" +
                                bedRoomMap.toString());
                            print("DISPLAY FURNISH TYPE ===>  " +
                                displayBedRooms.toString());

                            checkAreaTap = true;
                            print(checkAreaTap);
                            checkArea = index;
                            // title = tabList[index];

                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: checkArea == index
                                ? BoxDecoration(
                                    color: ColorRes.raioContainer,
                                    borderRadius: BorderRadius.circular(20),
                                  )
                                : BoxDecoration(),
                            width: Get.width / 4,
                            height: Get.height / 16,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border:
                                            Border.all(color: ColorRes.white)),
                                    // child: checkArea == index ? Icon(Icons.check,color: ColorRes.white,size: 18,) : Container(),
                                    child: bedRoomMap[bedRoomList[index]
                                                .toString()] ==
                                            true /*isChecked[index] == true*/
                                        ? Icon(
                                            Icons.check,
                                            color: ColorRes.white,
                                            size: 18,
                                          )
                                        : Container(),
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                      "${widget.preferenceModel!.data!.bedrooms![index].toString()} bhk",
                                      style: AppTextStyle(
                                          textColor: ColorRes.white, size: 16)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                InkWell(
                  onTap: () {
                    showPop = true;
                    Get.offAll(() => InterSelectionScreen());
                  },
                  child: CustomButton.myButton(AppRes.done),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: ColorRes.raioContainer,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllerBhk!.dispose();
    super.dispose();
  }
}
