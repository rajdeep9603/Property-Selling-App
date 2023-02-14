import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/bottom_part.dart';
import 'package:com.propacy.b2c/screen/search_area/search_select_area.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_loader_new.dart';
import 'package:com.propacy.b2c/utils/common_textstyle.dart';
import 'package:com.propacy.b2c/utils/common_will_pop_scope.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class InterSelectionScreen extends StatefulWidget {
  String? selectProperyRange;
  String? selectProperyRange2;
  String? radioTittle;
  String? property;

  InterSelectionScreen(
      {this.radioTittle,
      this.property,
      this.selectProperyRange,
      this.selectProperyRange2});

  @override
  State<InterSelectionScreen> createState() => _InterSelectionScreenState();
}

class _InterSelectionScreenState extends State<InterSelectionScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InterSelectionViewModel>.reactive(
      onModelReady: (model) {
        model.controller =
            AnimationController(vsync: this, duration: model.duration);
        model.init(model);
      },
      viewModelBuilder: () => InterSelectionViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            bool? settingTap = prefs.getBool("onTapProfile") ?? false;
            print(settingTap);
            if (settingTap == true) {
              print("no Alert Dialog");
              model.getBackPage();
            } else {
              showPop
                  ? appBackAlert()
                  : Get.offAll(() => InterSelectionScreen());
            }
            return true;
          },
          child: Scaffold(
            backgroundColor:
                model.isBusy ? Colors.transparent : ColorRes.bgColor,
            body: model.isBusy
                ? commonLoader()
                : preferenceModel.status == null ||
                        preferenceModel.status.toString() == "false"
                    ? commonLoader()
                    : SizedBox(
                        width: Get.width,
                        height: model.settingTap
                            ? Get.height + (Get.height / 2 - 32) + 50
                            : Get.height + (Get.height / 2 - 32),
                        child: model.stackLineShow
                            ? Stack(
                                children: [
                                  // SizedBox(
                                  //   width: Get.width,
                                  //   height: Get.height + (Get.height/2-32),
                                  // ),
                                  Positioned(
                                    top: 20,
                                    child: Column(
                                      children: [
                                        //main image
                                        Stack(
                                          children: [
                                            Container(
                                              width: Get.width,
                                              height: Get.height / 1.95,
                                              child: CachedNetworkImage(
                                                imageUrl: model.element != "" ||
                                                        model.element != null
                                                    ? model.element.toString()
                                                    : "http://via.placeholder.com/350x150",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      // colorFilter:
                                                      // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                        width: Get.width,
                                                        height:
                                                            Get.height / 2.5,
                                                        child: Image.asset(
                                                          "assets/image/house.jpg",
                                                          fit: BoxFit.fill,
                                                        )),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Container(
                                                        width: Get.width,
                                                        height:
                                                            Get.height / 2.5,
                                                        child: Image.asset(
                                                          "assets/image/house.jpg",
                                                          fit: BoxFit.fill,
                                                        )),
                                              ),
                                            ),
                                            // Positioned(
                                            //     top: 14,
                                            //     right: 20,
                                            //     child: GestureDetector(
                                            //       onTap: logout,
                                            //       child: Container(
                                            //         alignment: Alignment.center,
                                            //         height: 40,
                                            //         width: 80,
                                            //         decoration: BoxDecoration(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   30),
                                            //           color: ColorRes.btnBg,
                                            //         ),
                                            //         child: Text(
                                            //           AppRes.logout,
                                            //           style: AppTextStyle(
                                            //               textColor:
                                            //                   ColorRes.darkBlue,
                                            //               size: 16,
                                            //               weight:
                                            //                   FontWeight.w600),
                                            //         ),
                                            //       ),
                                            //     )),
                                            Positioned(
                                              bottom: 0,
                                              child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    width: Get.width,
                                                    height: Get.height / 6,
                                                    child: Image.asset(
                                                      "assets/image/Shape 3.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  //bottom part
                                  Positioned(
                                    //bottom: 0,
                                    top: model.settingTap
                                        ? 0
                                        : Get.height / 1.83,
                                    child: SizedBox(
                                      height: (Get.height / 2 - 32) * 2,
                                      width: Get.width,
                                      child: BottomPart(
                                        back: model.getBackPage,
                                        settingTap: model.settingTap,
                                        isApartment: model.isApartment,
                                        readyToMove: model.readyToMove,
                                        isbhkTap: model.isbhkTap,
                                        bhkTap: model.bhkTap,
                                        // preferenceModel: model.preferenceModel,
                                        preferenceModel: preferenceModel,
                                        onProceedTap: () =>
                                            model.onProceedTap(context),
                                        zoneModel: model.zoneModel,
                                        areaSelectTap: model.areaSelectTap,
                                        selectArea: model.selectArea,
                                        selectRange: widget.selectProperyRange
                                            .toString(),
                                        selectRange2: widget.selectProperyRange2
                                            .toString(),
                                        rangeList2: propertyRangeList,
                                        rangeList: propertyRangeList,
                                        propertyShow: model.propertyShow,
                                        propertyRangeTap:
                                            model.propertyRangeTap,
                                        property: widget.property.toString(),
                                        radioTitle:
                                            widget.radioTittle.toString(),
                                        showOnBuy: model.showOnBuy,
                                        buyTap: model.onBuyTap,
                                        onApartmentTap1: model.onApartmentTap1,
                                        showProfessional:
                                            model.showProfessional,
                                        professionalTap:
                                            model.onProfessionalTap,
                                        onTapOccupationItem:
                                            model.selectedItemIndex,
                                        occupationText:
                                            preferenceModel.data!.occupation!,
                                        selectOccupation: model.isSelected,
                                        whiteIcon: model.whiteIcon,
                                        questionTap: model.questionTap,
                                        onQuestionTap: model.onQuestionTap,
                                        //animation
                                        // isLeftCollapsed: model.isLeftCollapsed,
                                        // isBottomCollapsed: model.isBottomCollapsed,
                                        // isRightCollapsed: model.isRightCollapsed,
                                        isTopCollapsed: model.isTopCollapsed,
                                        duration: model.duration,
                                        controller: model.controller,
                                      ),
                                    ),
                                  ),
                                  model.stackLineShow && !model.settingTap
                                      ? Positioned(
                                          top: Get.height / 1.83,
                                          child: Container(
                                            width: Get.width,
                                            height: 1.5,
                                            color: ColorRes.divider,
                                          ))
                                      : SizedBox(),
                                  //support url
                                  model.settingTap
                                      ? Positioned(
                                          bottom: 0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(bottom: 5),
                                            height: Get.height * 0.09,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                // border: Border.all(color: ColorRes.yellow)
                                                ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  AppRes
                                                      .proPacyInterNetPrivetLimited,
                                                  style: appVersionText,
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  AppRes.appVersion,
                                                  style: appVersionText,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              )
                            : Container(
                                child: SearchSelectAreaScreen(
                                  zoneModel: model.zoneModel,
                                ),
                              ),
                      ),
          ),
        );
      },
      onDispose: (model) {
        model.controller.dispose();
      },
    );
  }
}

//for search animation
Route create() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        SearchSelectAreaScreen(
            // zoneModel: model.zoneModel,
            ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class AnimatedRoute extends PageRouteBuilder {
  final Widget widget;

  AnimatedRoute(this.widget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
