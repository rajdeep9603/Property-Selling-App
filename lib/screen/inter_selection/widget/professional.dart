import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_textstyle.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Professional extends StatefulWidget {
  final VoidCallback professionalTap;
  final Function(int index) onTapOccupationItem;
  final List<String> occupationTitle;
  late final int selectOccupation;
  final List<String> whiteIcon;
  final VoidCallback questionTap;
  final bool questionSelect;
  final bool isTopCollapsed;
  final String selectedString;
  bool settingTap;

  Professional(
      {Key? key,
      required this.professionalTap,
      required this.onTapOccupationItem,
      required this.occupationTitle,
      required this.selectOccupation,
      required this.whiteIcon,
      required this.questionTap,
      required this.questionSelect,
      required this.isTopCollapsed,
      required this.settingTap,
      required this.selectedString,
      })
      : super(key: key);

  @override
  State<Professional> createState() => _ProfessionalState();
}

class _ProfessionalState extends State<Professional>
    with SingleTickerProviderStateMixin {
  AnimationController? controller1;
  bool animated = true;

  @override
  void initState() {
    controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Future.delayed(100.milliseconds, () {
      setState(() {
        animated = false;
      });
    });

    // for(int i=0;i<=widget.occupationTitle.length;i++){
    //
    // if(  widget.occupationTitle[i].toString()==widget.selectOccupation.toString()){
    //   widget.selectOccupation=i;
    // }
    // }
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
          // duration: Duration(seconds: 3),
          // curve: Curves.easeInOut,
          // height: Get.height * 0.4 + 32,
          height: Get.height / 2 - 32,
          width: Get.width,
          color: ColorRes.containerbgColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        // Divider(color: ColorRes.raioContainer,thickness: 1.5),
                        Padding(
                          // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppRes.occupation,
                                    style: titleBottomPartTextStyle,
                                  ),
                                  GestureDetector(
                                      onTap: widget.questionTap,
                                      child: Image.asset(
                                          "assets/icons/questionmark.png"))
                                ],
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.occupationTitle.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        widget.professionalTap();
                                        widget.onTapOccupationItem(index);
                                        occupationName =
                                            widget.occupationTitle[index];
                                        widget.selectOccupation=index;

                                        // widget.settingTap = false;
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        //margin: EdgeInsets.only(top:10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: 40,
                                        width: Get.width - 20,
                                        decoration: BoxDecoration(
                                            // border: Border.all(width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            /*color: widget.selectOccupation ==
                                                    index*/
                                            color: widget.selectedString ==
                                                widget.occupationTitle[index]
                                                ? ColorRes.btnBg
                                                : ColorRes.containerbgColor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              widget.whiteIcon[index],
                                              /*color: widget.selectOccupation ==
                                                      index*/
                                              color: widget.selectedString ==
                                                  widget.occupationTitle[index]
                                                  ? ColorRes.black
                                                  : ColorRes.white,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              widget.occupationTitle[index],
                                              style: AppTextStyle(
                                                  /*textColor:
                                                      widget.selectOccupation ==
                                                              index*/
                                                  textColor: widget.selectedString ==
                                                      widget.occupationTitle[index]
                                                          ? ColorRes.black
                                                          : ColorRes.white,
                                                  size: 18,
                                                  weight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    widget.questionSelect == true
                        ? Positioned(
                            right: 0,
                            top: 20,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              height: 185,
                              width: Get.width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                                color: ColorRes.btnBg,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppRes.whyDoWeNeedThis,
                                        style: AppTextStyle(
                                            size: 14,
                                            textColor: ColorRes.bgColor,
                                            weight: FontWeight.bold),
                                      ),
                                      InkWell(
                                          onTap: widget.questionTap,
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: ColorRes.black,
                                            size: 22,
                                          ))
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10),
                                    child: Text(
                                      AppRes.contentWhy,
                                      style: AppTextStyle(
                                          size: 14,
                                          textColor: ColorRes.darkBlue,
                                          weight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        : SizedBox()
                  ],
                ),
                // SizedBox(height: 15),
                Divider(
                  thickness: 2,
                  color: ColorRes.raioContainer,
                ),
              ],
            ),
          )),
    );
  }
}
