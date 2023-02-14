import 'package:com.propacy.b2c/model/get_preference_model.dart';
import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/rest_api/post_preference_api.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/apartment_selection.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/bhk_select.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/buyMenuIteam.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/professional.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/property_range_slider.dart';
import 'package:com.propacy.b2c/screen/inter_selection/setting_part/setting_part.dart';
import 'package:com.propacy.b2c/screen/search_area/search_select_area.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_textstyle.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomPart extends StatelessWidget {
  final String selectRange;
  final GetZonesModel zoneModel;
  final GetPreferenceModel preferenceModel;
  final String selectRange2;
  final List<String> rangeList;
  final List<String> rangeList2;
  final String radioTitle;
  final String property;
  final bool showProfessional;
  final bool showOnBuy;
  final bool propertyShow;
  final bool selectArea;
  final bool isbhkTap;
  final VoidCallback professionalTap;
  final VoidCallback propertyRangeTap;
  final VoidCallback buyTap;
  final VoidCallback onApartmentTap1;
  final Function(int index) onTapOccupationItem;
  final List<String> occupationText;
  final int selectOccupation;
  final List<String> whiteIcon;
  final bool questionTap;
  final bool isApartment;
  final VoidCallback onQuestionTap;
  final VoidCallback areaSelectTap;
  final VoidCallback onProceedTap;
  final VoidCallback bhkTap;
  final VoidCallback readyToMove;
  final bool settingTap;
  final VoidCallback back;

  //animation
  final bool isTopCollapsed;
  final Duration duration;
  final AnimationController controller;

  BottomPart(
      {Key? key,
      required this.zoneModel,
      required this.preferenceModel,
      required this.selectRange,
      required this.selectRange2,
      required this.rangeList,
      required this.rangeList2,
      required this.radioTitle,
      required this.property,
      required this.showProfessional,
      required this.showOnBuy,
      required this.propertyShow,
      required this.professionalTap,
      required this.propertyRangeTap,
      required this.buyTap,
      required this.onApartmentTap1,
      required this.selectArea,
      required this.onTapOccupationItem,
      required this.occupationText,
      required this.selectOccupation,
      required this.whiteIcon,
      required this.questionTap,
      required this.onQuestionTap,
      required this.areaSelectTap,
      required this.onProceedTap,
      required this.isbhkTap,
      required this.isApartment,
      required this.readyToMove,
      required this.bhkTap,
      required this.settingTap,
      required this.back,
      //animation
      required this.isTopCollapsed,
      required this.duration,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showProfessional == false) {
      return showOnBuy == false
          ? propertyShow == false
              ? selectArea == false
                  ? isbhkTap == false
                      ? isApartment == false
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: (Get.height / 2 - 32) * 2,
                              width: Get.width,
                              alignment: isTopCollapsed
                                  ? Alignment.bottomCenter
                                  : Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  // border: Border.all(color: ColorRes.white),
                                  color: ColorRes.bgColor,
                                ),
                                height: settingTap
                                    ? Get.height
                                    : Get.height / 2 - 32,
                                width: Get.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // Divider(color: ColorRes.raioContainer,thickness: 1,),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            settingTap
                                                ? SizedBox(
                                                    height: 25,
                                                  )
                                                : SizedBox(),
                                            settingTap
                                                ? InkWell(
                                                    onTap: back,
                                                    child: Container(
                                                      // padding: EdgeInsets.only(left: 5),
                                                      height: 25,
                                                      width: 30,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Icon(
                                                        Icons.arrow_back,
                                                        color: ColorRes.white,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            settingTap
                                                ? SizedBox(
                                                    height: 5,
                                                  )
                                                : SizedBox(),
                                            Container(
                                              //text in main preferences
                                              margin: EdgeInsets.only(top: 5),
                                              height: Get.height * 0.3 - 10,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: settingTap
                                                            ? Text(
                                                                AppRes
                                                                    .changeYourPreferencesBelow,
                                                                style:
                                                                    titleBottomPartTextStyle,
                                                              )
                                                            : Text(
                                                                AppRes
                                                                    .ChooseYourPreferencesBelow,
                                                                style:
                                                                    titleBottomPartTextStyle,
                                                              )),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, right: 0),
                                                      // height: Get.height/2,
                                                      // width: Get.width - 40,
                                                      //decoration: BoxDecoration(border: Border.all(width: 2)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    AppRes
                                                                        .i_am_a,
                                                                    style:
                                                                        selectionText),
                                                                GestureDetector(
                                                                    onTap:
                                                                        professionalTap,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(occupationName??"Profession",
                                                                            /*loginHasPref
                                                                                ? loginOccupation ?? "Profession"
                                                                                : isThisScreenFromProfile
                                                                                    ? userProfileFromTap ?? "Profession"
                                                                                    : occupationName ?? "Profession",*/
                                                                            style: bSelectionText),
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_outlined,
                                                                          color:
                                                                              ColorRes.white,
                                                                          size:
                                                                              28,
                                                                        ),
                                                                      ],
                                                                    )),
                                                                // Image.asset(
                                                                //   "assets/icons/arrow_down.png",
                                                                //   fit: BoxFit.cover,
                                                                //   color: ColorRes.white,
                                                                // ),

                                                                Text(
                                                                    AppRes
                                                                        .lookingTo,
                                                                    style:
                                                                        selectionText),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Row(
                                                              children: [
                                                                // onRadioTap == true ? Text(radioTitle,style: bSelectionText):Text(AppRes.buy, style: bSelectionText),

                                                                InkWell(
                                                                    onTap:
                                                                        buyTap,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(radio1??"Buy",
                                                                           /* loginHasPref
                                                                                ? loginType
                                                                                : isThisScreenFromProfile
                                                                                    ? intentFromTap
                                                                                    : radio1 ?? AppRes.buy,*/
                                                                            style: bSelectionText),
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_outlined,
                                                                          color:
                                                                              ColorRes.white,
                                                                          size:
                                                                              28,
                                                                        ),
                                                                      ],
                                                                    )),
                                                                Text(AppRes.a,
                                                                    style:
                                                                        selectionText),

                                                                InkWell(
                                                                  onTap:
                                                                      readyToMove,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(radioReadytomove??"Ready to move",
                                                                          /*loginHasPref
                                                                              ? loginReadyToMove
                                                                              : isThisScreenFromProfile
                                                                                  ? typeFromTap
                                                                                  : radioReadytomove ?? AppRes.ready,*/
                                                                          style: bSelectionText),
                                                                      Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down_outlined,
                                                                        color: ColorRes
                                                                            .white,
                                                                        size:
                                                                            28,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // onPropertyTap == true ? Text(property,style: bSelectionText):Text(AppRes.ready, style: bSelectionText),

                                                                // Icon(Icons.keyboard_arrow_down_sharp,color: ColorRes.white,size: 30,)
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),

                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      onApartmentTap1,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(selectedApartment??"Apartment",
                                                                          /*loginHdasPref
                                                                              ? loginCategory
                                                                              : isThisScreenFromProfile
                                                                                  ? categoryFromTap
                                                                                  : selectedApartment ?? "Apartment",*/
                                                                          style: bSelectionText),
                                                                      Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down_outlined,
                                                                        color: ColorRes
                                                                            .white,
                                                                        size:
                                                                            28,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Text(AppRes.of,
                                                                    style:
                                                                        selectionText),
                                                                InkWell(
                                                                    onTap:
                                                                        bhkTap,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(selectedbhk??"2",
                                                                            /*loginHasPref
                                                                                ? loginBedroom + " bhk"
                                                                                : isThisScreenFromProfile
                                                                                    ? "$bedRoomFromTap" + " bhk"
                                                                                    : selectedbhk ?? "2 bhk",*/
                                                                            style: bSelectionText),
                                                                        Text(" bhk",
                                                                            style: bSelectionText),
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_outlined,
                                                                          color:
                                                                              ColorRes.white,
                                                                          size:
                                                                              28,
                                                                        ),
                                                                      ],
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 0,
                                                          ),
                                                          // Row(
                                                          //   children: [
                                                          //     // onPropertyTap == true ? Text(property,style: bSelectionText):Text(AppRes.apartment, style: bSelectionText),
                                                          //
                                                          //
                                                          //     // Icon(Icons.keyboard_arrow_down_sharp,color: ColorRes.white,size: 30,)
                                                          //   ],
                                                          // ),
                                                          // SizedBox(
                                                          //   height:10,
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, right: 0),
                                                      height:
                                                          Get.height * 0.09 + 3,
                                                      width: Get.width - 38,
                                                      //decoration: BoxDecoration(border: Border.all(width: 2)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  AppRes.MyBudget,
                                                                  style:
                                                                      selectionText,
                                                                ),
                                                                InkWell(
                                                                    onTap:
                                                                        propertyRangeTap,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(range3??"80.0 Lac - 90.0 Lac",
                                                                           /* loginArea
                                                                                ? loginRange
                                                                                : localArea
                                                                                    ? rangeOnTap ?? "5K - 10K"
                                                                                    : range3 ?? "80 - 90 lac",*/
                                                                            style: bSelectionText),
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_outlined,
                                                                          color: ColorRes
                                                                              .white,
                                                                          size:
                                                                              25,
                                                                        ),
                                                                      ],
                                                                    )),
                                                                // child: selectedRange == true || selectedRange2 == true ? Text("$selectRange - $selectRange2" ?? AppRes.lacs, style: bSelectionText):Text(AppRes.lacs, style: bSelectionText)),

                                                                Text(
                                                                  AppRes.inn,
                                                                  style:
                                                                      selectionText,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    areaSelectTap,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      /* loginHasPref
                                                                            ? loginLocality==[]?"Select":loginLocality
                                                                            :*/
                                                                      locOnTap ??
                                                                          "Select",
                                                                      style:
                                                                          bSelectionText,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_outlined,
                                                                      color: ColorRes
                                                                          .white,
                                                                      size: 28,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                AppRes.area,
                                                                style:
                                                                    selectionText,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: onProceedTap,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                alignment: Alignment.center,
                                                height: 45,
                                                width: Get.width - 10,
                                                decoration: BoxDecoration(
                                                    // border:
                                                    //     Border.all(width: 2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    color: ColorRes.btnBg),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppRes.proceed,
                                                      style: AppTextStyle(
                                                          textColor:
                                                              ColorRes.darkBlue,
                                                          size: 16,
                                                          weight:
                                                              FontWeight.w600),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: ColorRes.darkBlue,
                                                      size: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: ColorRes.raioContainer,
                                        thickness: 1,
                                      ),
                                      settingTap
                                          ? SettingPart.settingSection()
                                          : SizedBox()
                                      // SizedBox(
                                      //   height: Get.height*0.003,
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : ApartmentSelection(preferenceModel: preferenceModel)
                      : BhkSelectScreen(preferenceModel: preferenceModel)
                  : /*SearchArea(zoneModel: zoneModel)*/ SearchSelectAreaScreen(
                      zoneModel: zoneModel,
                    )
              : PropertyRange(
                  rangeListWidgets: rangeList,
                  rangeListWidgets2: rangeList2,
                )
          : BuyMenuIteam(
              preferenceModel: preferenceModel,
              // isTopCollapsed: isTopCollapsed,
              //  controller: controller,
            );
    } else {
      return Professional(
        professionalTap: professionalTap,
        occupationTitle: occupationText,
        onTapOccupationItem: onTapOccupationItem,
        selectOccupation: selectOccupation,
        whiteIcon: whiteIcon,
        questionTap: onQuestionTap,
        questionSelect: questionTap,
        isTopCollapsed: isTopCollapsed,
        settingTap: settingTap,
        selectedString: occupationName??"Profession",
      );
    }
  }
}
