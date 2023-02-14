import 'package:com.propacy.b2c/model/get_preference_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
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

var loginCatListCheck;

class BuyMenuIteam extends StatefulWidget {
  GetPreferenceModel? preferenceModel;

  // bool isTopCollapsed = true;
  // AnimationController? controller;
  BuyMenuIteam({
    this.preferenceModel,
    /*required this.isTopCollapsed,required this.controller*/
  });

  @override
  State<BuyMenuIteam> createState() => _BuyMenuIteamState();
}

class _BuyMenuIteamState extends State<BuyMenuIteam>
    with SingleTickerProviderStateMixin {
  AnimationController? controllerBuy;
  bool animated = true;

  int? radioSelected = 1;

  String? _radioVal;
  String? radioTittle;
  String? property = AppRes.unfurnish;
  int checkArea = 0;
  bool? checkAreaTap = false;

  @override
  void initState() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.load, Str.lPreferences_propType_page);
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.load, Str.lPreferences_category_page);
    radioTittle = widget.preferenceModel!.data!.lookingTo![0].toString();
    property = widget.preferenceModel!.data!.lookingFor![0].toString();
    controllerBuy =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Future.delayed(100.milliseconds, () {
      setState(() {
        animated = false;
      });
    });
    loginCatListCheck = SharePref.getString("loginLocality");
    print(loginCatListCheck);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: (Get.height / 2 - 32) * 2,
      width: Get.width,
      alignment: animated ? Alignment.bottomCenter : Alignment.topCenter,
      child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white)
          // ),
          height: Get.height / 2 - 32,
          width: Get.width,
          color: ColorRes.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: Get.height * 0.4 - 40,
                      margin: EdgeInsets.only(top: 5),
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: ColorRes.whiteText)
                      // ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(AppRes.buyMenutitle1,
                                  style: titleBottomPartTextStyle),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // onRadioTap = true;
                                      FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_propType_selected);
                                      //global
                                      radio1 = widget
                                          .preferenceModel!.data!.lookingTo![0]
                                          .toString();

                                      radioTittle = widget
                                          .preferenceModel!.data!.lookingTo![0]
                                          .toString();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: Get.width / 2.7,
                                      height: Get.height / 18,
                                      decoration: radioTittle ==
                                              widget.preferenceModel!.data!
                                                  .lookingTo![0]
                                                  .toString()
                                          ? BoxDecoration(
                                              color: ColorRes.raioContainer,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // border: Border.all(color: ColorRes.white,width: 2),
                                            )
                                          : BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  //border: Border.all(color: ColorRes.white,width: 2),
                                                ),
                                                child: radioTittle ==
                                                        widget.preferenceModel!
                                                            .data!.lookingTo![0]
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
                                                widget.preferenceModel!.data!
                                                    .lookingTo![0]
                                                    .toString(),
                                                style: radioTittle ==
                                                        widget.preferenceModel!
                                                            .data!.lookingTo![0]
                                                            .toString()
                                                    ? AppTextStyle(
                                                        textColor:
                                                            ColorRes.white,
                                                        size: 16,
                                                        weight: FontWeight.w600)
                                                    : radioTextStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width / 8),
                                  InkWell(
                                    onTap: () {
                                      FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_propType_selected);
                                      // radio1 = widget.preferenceModel!.data!.lookingTo![1].toString();
                                      // radioTittle = widget.preferenceModel!.data!.lookingTo![1].toString();
                                      // setState(() {});
                                      ToastDisplay.myToast();
                                    },
                                    child: Container(
                                      width: Get.width / 2.7,
                                      height: Get.height / 18,
                                      decoration: radioTittle ==
                                              widget.preferenceModel!.data!
                                                  .lookingTo![1]
                                                  .toString()
                                          ? BoxDecoration(
                                              color: ColorRes.raioContainer,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // border: Border.all(color: ColorRes.white,width: 2),
                                            )
                                          : BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  // border: Border.all(color: ColorRes.white,width: 2),
                                                ),
                                                child: radioTittle ==
                                                        widget.preferenceModel!
                                                            .data!.lookingTo![1]
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
                                                widget.preferenceModel!.data!
                                                    .lookingTo![1]
                                                    .toString(),
                                                style: radioTittle ==
                                                        widget.preferenceModel!
                                                            .data!.lookingTo![1]
                                                            .toString()
                                                    ? AppTextStyle(
                                                        textColor:
                                                            ColorRes.white,
                                                        size: 16,
                                                        weight: FontWeight.w600)
                                                    : radioTextStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_propType_selected);
                                      // radio1 = widget.preferenceModel!.data!.lookingTo![2].toString();
                                      // radioTittle = widget.preferenceModel!.data!.lookingTo![2].toString();
                                      // setState(() {});
                                      ToastDisplay.myToast();
                                    },
                                    child: Container(
                                      width: Get.width / 2.7,
                                      height: Get.height / 18,
                                      decoration: radioTittle ==
                                              widget.preferenceModel!.data!
                                                  .lookingTo![2]
                                                  .toString()
                                          ? BoxDecoration(
                                              color: ColorRes.raioContainer,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // border: Border.all(color: ColorRes.white,width: 2),
                                            )
                                          : BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  // border: Border.all(color: ColorRes.white,width: 2),
                                                ),
                                                child: radioTittle ==
                                                        widget.preferenceModel!
                                                            .data!.lookingTo![2]
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
                                                widget.preferenceModel!.data!
                                                    .lookingTo![2]
                                                    .toString(),
                                                style: radioTittle ==
                                                        widget.preferenceModel!
                                                            .data!.lookingTo![2]
                                                            .toString()
                                                    ? AppTextStyle(
                                                        textColor:
                                                            ColorRes.white,
                                                        size: 16,
                                                        weight: FontWeight.w600)
                                                    : radioTextStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width / 8),
                                  InkWell(
                                    onTap: () {
                                      FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_propType_selected);
                                      // radio1 = widget.preferenceModel!.data!.lookingTo![3].toString();
                                      // radioTittle = widget.preferenceModel!.data!.lookingTo![3].toString();
                                      // setState(() {});
                                      ToastDisplay.myToast();
                                    },
                                    child: Container(
                                      width: Get.width / 2.7,
                                      height: Get.height / 18,
                                      decoration: radioTittle ==
                                              widget.preferenceModel!.data!
                                                  .lookingTo![3]
                                                  .toString()
                                          ? BoxDecoration(
                                              color: ColorRes.raioContainer,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // border: Border.all(color: ColorRes.white,width: 2),
                                            )
                                          : BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                                // border: Border.all(color: ColorRes.white,width: 2),
                                              ),
                                              child: radioTittle ==
                                                      widget.preferenceModel!
                                                          .data!.lookingTo![3]
                                                          .toString()
                                                  ? Icon(
                                                      Icons.adjust_rounded,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )
                                                  : Image.asset(
                                                      "assets/icons/roundborder.png"),
                                            ),
                                            SizedBox(
                                              width: Get.width / 25,
                                            ),
                                            Text(
                                                widget.preferenceModel!.data!
                                                    .lookingTo![3]
                                                    .toString(),
                                                style: radioTittle ==
                                                        widget.preferenceModel!
                                                            .data!.lookingTo![3]
                                                            .toString()
                                                    ? AppTextStyle(
                                                        textColor:
                                                            ColorRes.white,
                                                        size: 16,
                                                        weight: FontWeight.w600)
                                                    : radioTextStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //SizedBox(height: Get.height*0.2-38,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(AppRes.apartTitle,
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
                                      physics: NeverScrollableScrollPhysics(),
                                      //  scrollDirection: Axis.vertical,
                                      itemCount: widget.preferenceModel!.data!
                                                  .category!.length ==
                                              0
                                          ? 0
                                          : widget.preferenceModel!.data!
                                              .category!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            // for(var ele in categoriesList){
                                            //   if(selectedApartment== ele){
                                            //     categoryMap[categoriesList[index].toString()]=true;
                                            //   }
                                            // }

                                            FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_category_selected);
                                            if (categoryMap[
                                                    categoriesList[index]
                                                        .toString()] ==
                                                true) {
                                              setState(() {
                                                categoryMap[
                                                    categoriesList[index]
                                                        .toString()] = false;
                                                for (var ele
                                                    in categoriesList) {
                                                  if (categoryMap[ele] ==
                                                      true) {
                                                    selectedApartment =
                                                        ele.toString();
                                                    break;
                                                  } else {
                                                    selectedApartment =
                                                        "Apartment";
                                                  }
                                                }
                                                displayCat.remove(
                                                    categoriesList[index]
                                                        .toString());
                                              });
                                            } else {
                                              setState(() {
                                                selectedApartment = widget
                                                    .preferenceModel!
                                                    .data!
                                                    .category![index]
                                                    .toString();
                                                categoryMap[
                                                    categoriesList[index]
                                                        .toString()] = true;
                                                displayCat.add(
                                                    categoriesList[index]
                                                        .toString());
                                              });
                                            }
                                            print("AFTER CHANGE====>" +
                                                categoryMap.toString());
                                            print("DISPLAY CATEGORY ===>  " +
                                                displayCat.toString());

                                            //isChecked[index] = !isChecked[index];

                                            //checkBoolListSize!.add(isChecked[index]);

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
                                            decoration: checkArea == index
                                                ? BoxDecoration(
                                                    color:
                                                        ColorRes.raioContainer,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  )
                                                : BoxDecoration(),
                                            width: Get.width / 4,
                                            height: Get.height / 16,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        border: Border.all(
                                                            color: ColorRes
                                                                .white)),
                                                    // child: checkArea == index ? Icon(Icons.check,color: ColorRes.white,size: 18,) : Container(),
                                                    child: categoryMap[
                                                                categoriesList[
                                                                        index]
                                                                    .toString()] ==
                                                            true
                                                        ? Icon(
                                                            Icons.check,
                                                            color:
                                                                ColorRes.white,
                                                            size: 18,
                                                          )
                                                        : Container(),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                      "${widget.preferenceModel!.data!.category![index].toString()}",
                                                      style: categoryMap[
                                                                  categoriesList[
                                                                          index]
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
                            ),
                          ],
                        ),
                      ),
                    ),

                    /*      Text(AppRes.buyMenutitle2,style:titleBottomPartTextStyle),
                    SizedBox(height: 5,),
                    InkWell(
                      onTap: (){
                        radio2 = widget.preferenceModel!.data!.lookingFor![0].toString();
                        // onPropertyTap = true;
                        property = widget.preferenceModel!.data!.lookingFor![0].toString();
                        setState(() {});
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.height/18,
                        decoration: property == widget.preferenceModel!.data!.lookingFor![0].toString() ? BoxDecoration(
                          color: ColorRes.raioContainer,
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: ColorRes.white,width: 2),
                        ):BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  //border: Border.all(color: ColorRes.white,width: 2),
                                ),

                                child: property == widget.preferenceModel!.data!.lookingFor![0].toString() ?
                                Icon(Icons.adjust_rounded,color: Colors.white,size: 20,) :
                                Image.asset("assets/icons/roundborder.png")
                              ),
                              SizedBox(width: 15,),
                              Text(widget.preferenceModel!.data!.lookingFor![0].toString(),
                                  style: property == widget.preferenceModel!.data!.lookingFor![0].toString() ?
                                  AppTextStyle(textColor: ColorRes.white,size: 15)
                              :radioTextStyle),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //// SizedBox(height: 5,),
                    InkWell(
                      onTap: (){
                        radio2 = widget.preferenceModel!.data!.lookingFor![1].toString();
                        property = widget.preferenceModel!.data!.lookingFor![1].toString();
                        setState(() {});
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.height/18,
                        decoration: property == widget.preferenceModel!.data!.lookingFor![1].toString() ? BoxDecoration(
                          color: ColorRes.raioContainer,
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: ColorRes.white,width: 2),
                        ):BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                 // border: Border.all(color: ColorRes.white,width: 2),
                                ),
                                child: property == widget.preferenceModel!.data!.lookingFor![1].toString() ? Icon(Icons.adjust_rounded,color: Colors.white,size: 20,)
                                    : Image.asset("assets/icons/roundborder.png")
                              ),
                              SizedBox(width: 15,),
                              Text(widget.preferenceModel!.data!.lookingFor![1].toString(),
                                  style: property == widget.preferenceModel!.data!.lookingFor![1].toString() ?
                                  AppTextStyle(textColor: ColorRes.white,size: 15)
                              :radioTextStyle),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //// SizedBox(height: 5,),
                    InkWell(
                      onTap: (){
                        radio2 = widget.preferenceModel!.data!.lookingFor![2].toString();
                        property = widget.preferenceModel!.data!.lookingFor![2].toString();
                        setState(() {});
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.height/18,
                        decoration: property == widget.preferenceModel!.data!.lookingFor![2].toString() ? BoxDecoration(
                          color: ColorRes.raioContainer,
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(color: ColorRes.white,width: 2),
                        ):BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                //  border: Border.all(color: ColorRes.white,width: 2),
                                ),
                                child: property == widget.preferenceModel!.data!.lookingFor![2].toString()
                                    ? Icon(Icons.adjust_rounded,color: Colors.white,size: 20,)
                                    :Image.asset("assets/icons/roundborder.png")
                              ),
                              SizedBox(width: 15,),
                              Text(widget.preferenceModel!.data!.lookingFor![2].toString(),
                                  style: property == widget.preferenceModel!.data!.lookingFor![2].toString()
                                      ?AppTextStyle(textColor: ColorRes.white,size: 15)
                              :radioTextStyle),
                            ],
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: 10,),*/

                    InkWell(
                        onTap: () {
                          showPop = true;
                          Get.offAll(() => InterSelectionScreen(
                                radioTittle: radioTittle,
                                property: property,
                              ));
                        },
                        child: CustomButton.myButton(AppRes.done)),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 2,
                      color: ColorRes.raioContainer,
                    ),
                  ],
                ),
              ),

              // SizedBox(height: 5,),
            ],
          )),
    );
  }

  @override
  void dispose() {
    controllerBuy!.dispose();
    super.dispose();
  }
}
