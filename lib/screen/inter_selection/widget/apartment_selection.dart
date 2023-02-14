import 'package:com.propacy.b2c/model/get_preference_model.dart';
import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_textstyle.dart';
import 'package:com.propacy.b2c/utils/custom_button.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///this screen open when tap on ready-to-move

class ApartmentSelection extends StatefulWidget {
  GetPreferenceModel? preferenceModel;

  ApartmentSelection({this.preferenceModel});

  @override
  _ApartmentSelectionState createState() => _ApartmentSelectionState();
}

class _ApartmentSelectionState extends State<ApartmentSelection>
    with SingleTickerProviderStateMixin {
  AnimationController? controllerReady;
  bool animated = true;

  List<bool> isChecked = List.generate(100, (index) => false);
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
  int? radioSelected = 1;
  String? _radioVal;
  String? radioTittletype;
  String? property = AppRes.readyToMove;

  @override
  void initState() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.load, Str.lPreferences_userType_page);
    print(radioReadytomove);
    print(furnishTypesList);
    if(radioReadytomove=="Ready to move"){
      radioTittletype = widget.preferenceModel!.data!.type![0].toString();
      furnishTypesList.forEach((element) {
        furnishTypesMap.addAll({element:true});
        if(displayFurnish.contains(element)==false){
          displayFurnish.add(element);
        }
      });
      print("FURNISHTYPE MAP SELECT READY TO MOVE"+furnishTypesMap.toString());

    }else{
      radioTittletype = widget.preferenceModel!.data!.type![1].toString();
    }

    property = widget.preferenceModel!.data!.type![0].toString();
    controllerReady =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Future.delayed(100.milliseconds, () {
      setState(() {
        animated = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: (Get.height / 2 - 32) * 2,
        width: Get.width,
        alignment: animated ? Alignment.bottomCenter : Alignment.topCenter,
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          // height: Get.height * 0.4 + 32,
          height: Get.height / 2 - 32,
          width: Get.width,
          decoration: BoxDecoration(
            //  border: Border.all(width: 2, color: Colors.white),
            color: ColorRes.containerbgColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height * 0.4 - 40,
                        margin: EdgeInsets.only(top: 5),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    AppRes.typeHome,
                                    style: titleBottomPartTextStyle,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_userType_selected);

                                  radioReadytomove = widget
                                      .preferenceModel!.data!.type![0]
                                      .toString();

                                  // List<String> full=["Full"];
                                  // full.forEach((element) {
                                  //   furnishTypesMap.addIf(condition, key, value)
                                  // })

                                  radioTittletype = widget
                                      .preferenceModel!.data!.type![0]
                                      .toString();
                                  setState(() {
                                    //showHomeType = true;
                                  });
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: Get.height / 18,
                                  decoration: radioTittletype ==
                                          widget.preferenceModel!.data!.type![0]
                                              .toString()
                                      ? BoxDecoration(
                                          color: ColorRes.raioContainer,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // border: Border.all(color: ColorRes.white,width: 2),
                                        )
                                      : BoxDecoration(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              //border: Border.all(color: ColorRes.white,width: 2),
                                            ),
                                            child: radioTittletype ==
                                                    widget.preferenceModel!
                                                        .data!.type![0]
                                                        .toString()
                                                ? Icon(
                                                    Icons.adjust_rounded,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : Image.asset(
                                                    "assets/icons/roundborder.png")),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                            widget
                                                .preferenceModel!.data!.type![0]
                                                .toString(),
                                            style: radioTittletype ==
                                                    widget.preferenceModel!
                                                        .data!.type![0]
                                                        .toString()
                                                ? AppTextStyle(
                                                    textColor: ColorRes.white,
                                                    size: 15,
                                                    weight: FontWeight.w600)
                                                : apartmentTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  radioReadytomove = widget
                                      .preferenceModel!.data!.type![1]
                                      .toString();

                                  radioTittletype = widget
                                      .preferenceModel!.data!.type![1]
                                      .toString();
                                  setState(() {});
                                  setState(() {
                                    //showHomeType = false;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: Get.height / 18,
                                  decoration: radioTittletype ==
                                          widget.preferenceModel!.data!.type![1]
                                              .toString()
                                      ? BoxDecoration(
                                          color: ColorRes.raioContainer,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // border: Border.all(color: ColorRes.white,width: 2),
                                        )
                                      : BoxDecoration(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              //border: Border.all(color: ColorRes.white,width: 2),
                                            ),
                                            child: radioTittletype ==
                                                    widget.preferenceModel!
                                                        .data!.type![1]
                                                        .toString()
                                                ? Icon(
                                                    Icons.adjust_rounded,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : Image.asset(
                                                    "assets/icons/roundborder.png")),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                            widget
                                                .preferenceModel!.data!.type![1]
                                                .toString(),
                                            style: radioTittletype ==
                                                    widget.preferenceModel!
                                                        .data!.type![1]
                                                        .toString()
                                                ? AppTextStyle(
                                                    textColor: ColorRes.white,
                                                    size: 15,
                                                    weight: FontWeight.w600)
                                                : apartmentTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              radioTittletype ==
                                      widget.preferenceModel!.data!.type![0]
                                          .toString()
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(AppRes.furnishtype,
                                            style: titleBottomPartTextStyle),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        // zonesCome == true ? checkMultipleArea(zoneExpansionList:zoneExpansionList) : Container(),
                                        Container(
                                          width: Get.width,
                                          height: Get.height / 4.5,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              //  scrollDirection: Axis.vertical,
                                              itemCount: widget
                                                          .preferenceModel!
                                                          .data!
                                                          .furnishType!
                                                          .length ==
                                                      0
                                                  ? 0
                                                  : widget
                                                      .preferenceModel!
                                                      .data!
                                                      .furnishType!
                                                      .length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    // selectedApartment = widget
                                                    //     .preferenceModel!
                                                    //     .data!
                                                    //     .furnishType![index]
                                                    //     .toString();

                                                    if (furnishTypesMap[
                                                            furnishTypesList[
                                                                    index]
                                                                .toString()] ==
                                                        true) {
                                                      setState(() {
                                                        furnishTypesMap[
                                                                furnishTypesList[
                                                                        index]
                                                                    .toString()] =
                                                            false;
                                                        displayFurnish.remove(
                                                            furnishTypesList[
                                                                    index]
                                                                .toString());
                                                      });
                                                    } else {
                                                      setState(() {
                                                        furnishTypesMap[
                                                                furnishTypesList[
                                                                        index]
                                                                    .toString()] =
                                                            true;
                                                        displayFurnish.add(
                                                            furnishTypesList[
                                                                    index]
                                                                .toString());
                                                      });
                                                    }
                                                    print(
                                                        "AFTER CHANGE FURNISH TYPE====>" +
                                                            furnishTypesMap
                                                                .toString());
                                                    print(
                                                        "DISPLAY FURNISH TYPE ===>  " +
                                                            displayFurnish
                                                                .toString());

                                                    //  isChecked[index] = !isChecked[index];

                                                    // checkBoolListSize!.add(isChecked[index]);

                                                    // title = tabList[index];

                                                    // checkBoolListSize!
                                                    //     .add(isChecked[index]);

                                                    checkAreaTap = true;
                                                    print(checkAreaTap);
                                                    checkArea = index;

                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration:
                                                        checkArea == index
                                                            ? BoxDecoration(
                                                                color: ColorRes
                                                                    .raioContainer,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              )
                                                            : BoxDecoration(),
                                                    width: Get.width / 4,
                                                    height: Get.height / 16,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 20,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    color: ColorRes
                                                                        .white)),
                                                            // child: checkArea == index ? Icon(Icons.check,color: ColorRes.white,size: 18,) : Container(),
                                                            child: furnishTypesMap[
                                                                        furnishTypesList[index]
                                                                            .toString()] ==
                                                                    true /* isChecked[index] == true*/
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: ColorRes
                                                                        .white,
                                                                    size: 18,
                                                                  )
                                                                : Container(),
                                                          ),
                                                          SizedBox(width: 15),
                                                          Text(
                                                              "${widget.preferenceModel!.data!.furnishType![index].toString()}",
                                                              style: categoryMap[
                                                                          categoriesList[index]
                                                                              .toString()] ==
                                                                      true /*isChecked[index] ==
                                                      true */
                                                                  ? AppTextStyle(
                                                                      textColor:
                                                                          ColorRes
                                                                              .white,
                                                                      size: 16,
                                                                      weight: FontWeight
                                                                          .w600)
                                                                  : titleBottomPartTextStyle),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        // checkMultipleArea(zoneExpansionList:zoneExpansionList),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      height: Get.height * 0.2 - 25,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider(color: ColorRes.raioContainer,thickness: 2,),
                // SizedBox(height: Get.height*0.05,),
                InkWell(
                    onTap: () {
                      showPop = true;
                      Get.offAll(() => InterSelectionScreen());
                    },
                    child: CustomButton.myButton(AppRes.done)),
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
    controllerReady!.dispose();
    super.dispose();
  }
}
