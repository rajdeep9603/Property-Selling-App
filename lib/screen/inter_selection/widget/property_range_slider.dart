import 'dart:async';

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_textstyle.dart';
import 'package:com.propacy.b2c/utils/custom_button.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyRange extends StatefulWidget {
  List<String> rangeListWidgets;
  List<String> rangeListWidgets2;

  PropertyRange(
      {required this.rangeListWidgets, required this.rangeListWidgets2});

  @override
  _PropertyRangeState createState() => _PropertyRangeState();
}

class _PropertyRangeState extends State<PropertyRange>
    with SingleTickerProviderStateMixin {
  AnimationController? controllerRange;
  bool animated = true;

  double? r1;
  double? r2;

  int selectedItemIndex = 5;
  int selectedItemIndex2 = 5;
  final _scrollController1Min = FixedExtentScrollController();
  final _scrollControllerMin = FixedExtentScrollController();
  final _scrollController1Max = FixedExtentScrollController();
  final _scrollControllerMax = FixedExtentScrollController();

  Timer? upperSliderTimer;

  final double _itemHeight = 100.0;
  var currSelectRate;
  var currSelectRate2;

  @override
  void initState() {
    controllerRange =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Future.delayed(100.milliseconds, () {
      setState(() {
        animated = false;
      });
    });
    startMin();
    // startMax();
    // getRangeText();
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.load, Str.lPreferences_price_page);
    super.initState();
  }

  void startMin() {
    double counter = 0;
    double counterMax = 0;
    print("INIT OF PROPERTY RANGE " +
        minP.toString() +
        " - - - " +
        maxP.toString());
    Future.delayed(Duration(milliseconds: 500), () {
      print("RANGE LIST 1" + widget.rangeListWidgets.toString());
      print("RANGE LIST 2" + widget.rangeListWidgets2.toString());
      print(minP);
      for (String str in widget.rangeListWidgets) {
        if (str == /*str1*/ minP) {
          break;
        }
        counter = counter + 100;
      }
      for (String strMax in widget.rangeListWidgets2) {
        if (strMax == maxP) {
          break;
        }
        counterMax = counterMax + 100;
      }
      _scrollControllerMin.animateTo(counter,
          duration: Duration(milliseconds: 50), curve: Curves.easeInCubic);
      _scrollControllerMax.animateTo(counterMax,
          duration: Duration(milliseconds: 50), curve: Curves.easeInCubic);
    });
  }

  // getRangeText() async {
  //   print("INIT OF PROPERTY RANGE " +
  //       minP.toString() +
  //       " - - - " +
  //       maxP.toString());
  // }

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
        //decoration: BoxDecoration(border: Border.all(width: 2)),
        height: Get.height / 2 - 32,
        width: Get.width,
        //color: ColorRes.containerbgColor,
        child: Stack(
          children: [
            Container(
                child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      //Divider(color: ColorRes.raioContainer,thickness: 1,),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   color: ColorRes.divider.withOpacity(0.5),
                          //   border: Border.all(color: ColorRes.black),
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                AppRes.propertyRangeTitle,
                                style: titleBottomPartTextStyle,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: Get.width / 9),
                                  Container(
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(15),
                                    //   color: ColorRes.white.withOpacity(0.07),
                                    // ),
                                    //decoration: BoxDecoration(border: Border.all(width: 2)),
                                    width: Get.width / 3.8,
                                    height: Get.height / 4,
                                    child: ClickableListWheelScrollView(
                                      scrollController: _scrollController1Min,
                                      itemHeight: _itemHeight,
                                      itemCount: widget.rangeListWidgets.length,
                                      onItemTapCallback: (index) {
                                        // selectedRange = true;

                                        range1 = widget.rangeListWidgets[index]
                                            .toString();
                                        currSelectRate = widget
                                            .rangeListWidgets[index]
                                            .toString();
                                        setState(() {});
                                        print(
                                            "onItemTapCallback index: $index");
                                      },
                                      child: ListWheelScrollView.useDelegate(
                                        controller: _scrollControllerMin,
                                        itemExtent: _itemHeight,
                                        physics: FixedExtentScrollPhysics(),
                                        squeeze: 3,
                                        overAndUnderCenterOpacity: 0.3,
                                        // perspective: 0.002,
                                        diameterRatio: 1.3,
                                        useMagnifier: true,
                                        onSelectedItemChanged: (index) {
                                          // selectedRange = true;
                                          range1 = widget
                                              .rangeListWidgets[index]
                                              .toString();
                                          currSelectRate = widget
                                              .rangeListWidgets[index]
                                              .toString();

                                          print(
                                              "onSelectedItemChanged index: $index  , $currSelectRate");
                                          setState(() {});
                                        },

                                        childDelegate:
                                            ListWheelChildBuilderDelegate(
                                          builder: (context, index) => Container(
                                              alignment: Alignment.center,
                                              //decoration: BoxDecoration(border: Border.all(width: 2)),
                                              child: Text(
                                                widget.rangeListWidgets[index]
                                                    .toString(),
                                                style: AppTextStyle(
                                                    textColor: ColorRes.white,
                                                    size: 18,
                                                    weight: FontWeight.bold),
                                              )),
                                          childCount:
                                              widget.rangeListWidgets.length,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width / 9),
                                  Container(
                                    width: Get.width / 3.8,
                                    height: Get.height / 4,
                                    child: ClickableListWheelScrollView(
                                      scrollController: _scrollController1Max,
                                      itemHeight: _itemHeight,
                                      itemCount:
                                          widget.rangeListWidgets2.length,
                                      onItemTapCallback: (index) {
                                        currSelectRate2 = widget
                                            .rangeListWidgets2[index]
                                            .toString();
                                        range2 = widget.rangeListWidgets2[index]
                                            .toString();
                                        // selectedRange2 = true;
                                        setState(() {});
                                        print(
                                            "onItemTapCallback index: $index");
                                      },
                                      child: ListWheelScrollView.useDelegate(
                                        controller: _scrollControllerMax,
                                        itemExtent: _itemHeight,
                                        physics: FixedExtentScrollPhysics(),
                                        squeeze: 3,
                                        overAndUnderCenterOpacity: 0.3,
                                        // perspective: 0.002,
                                        diameterRatio: 1.3,
                                        useMagnifier: true,
                                        onSelectedItemChanged: (index) {
                                          range2 = widget
                                              .rangeListWidgets2[index]
                                              .toString();
                                          // selectedRange2 = true;
                                          currSelectRate2 = widget
                                              .rangeListWidgets2[index]
                                              .toString();
                                          setState(() {});
                                          print(
                                              "onSelectedItemChanged index: $index  , $currSelectRate2");
                                        },
                                        childDelegate:
                                            ListWheelChildBuilderDelegate(
                                          builder: (context, index) =>
                                              Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    widget.rangeListWidgets2[
                                                            index]
                                                        .toString(),
                                                    style: AppTextStyle(
                                                        textColor:
                                                            ColorRes.white,
                                                        size: 18,
                                                        weight:
                                                            FontWeight.bold),
                                                  )),
                                          childCount:
                                              widget.rangeListWidgets2.length,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width / 20),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (range2 != null && range1 != null) {
                                    setState(() {
                                      selectedMinPrize = range1;
                                      selectedMaxPrize = range2;
                                      String lastrange1 = range1!.substring(
                                          range1!.lastIndexOf(" ") + 1);
                                      print(lastrange1);

                                      String lastrange2 = range2!.substring(
                                          range2!.lastIndexOf(" ") + 1);
                                      print(lastrange2);

                                      if (lastrange1 == "Cr") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r1);
                                      } else if (lastrange1 == "Lac") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r1);
                                      } else if (lastrange1 == "K") {
                                        r1 = int.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r1);
                                      }
                                      if (lastrange2 == "Cr") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r2);
                                      } else if (lastrange2 == "Lac") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r2);
                                      } else if (lastrange2 == "K") {
                                        r2 = int.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r2);
                                      }
                                      if (r1! >= r2!) {
                                        print("Select range1 lessthen range2");
                                        Fluttertoast.showToast(
                                          msg: "Select range1 lessthen range2",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: ColorRes.textGrey,
                                          textColor: Colors.white,
                                          fontSize: 18,
                                        );
                                      } else {
                                        print("Range1 is lessthen range2");
                                        print("$range1 - $range2");
                                        range3 = "$range1" + " to " + "$range2";
                                        Get.offAll(() => InterSelectionScreen(
                                              selectProperyRange:
                                                  currSelectRate,
                                              selectProperyRange2:
                                                  currSelectRate2,
                                            ));
                                      }
                                    });
                                  } else if (range2 != null) {
                                    range1 =
                                        widget.rangeListWidgets[0].toString();
                                    setState(() {
                                      selectedMinPrize = range1;
                                      selectedMaxPrize = range2;
                                      String lastrange1 = range1!.substring(
                                          range1!.lastIndexOf(" ") + 1);
                                      print(lastrange1);

                                      String lastrange2 = range2!.substring(
                                          range2!.lastIndexOf(" ") + 1);
                                      print(lastrange2);

                                      if (lastrange1 == "Cr") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r1);
                                      } else if (lastrange1 == "Lac") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r1);
                                      } else if (lastrange1 == "K") {
                                        r1 = int.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r1);
                                      }
                                      if (lastrange2 == "Cr") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r2);
                                      } else if (lastrange2 == "Lac") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r2);
                                      } else if (lastrange2 == "K") {
                                        r2 = int.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r2);
                                      }
                                      if (r1! >= r2!) {
                                        print("Select range1 lessthen range2");
                                        Fluttertoast.showToast(
                                          msg: "Select range1 lessthen range2",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: ColorRes.textGrey,
                                          textColor: Colors.white,
                                          fontSize: 18,
                                        );
                                      } else {
                                        print("Range1 is lessthen range2");
                                        print("$range1 - $range2");
                                        range3 = "$range1" + " to " + "$range2";
                                        Get.offAll(() => InterSelectionScreen(
                                              selectProperyRange:
                                                  currSelectRate,
                                              selectProperyRange2:
                                                  currSelectRate2,
                                            ));
                                      }
                                    });
                                    // Get.offAll(()=>InterSelectionScreen(selectProperyRange: currSelectRate,selectProperyRange2: currSelectRate2,));
                                  } else if (range1 != null) {
                                    range2 =
                                        widget.rangeListWidgets2[0].toString();
                                    setState(() {
                                      selectedMinPrize = range1;
                                      selectedMaxPrize = range2;
                                      String lastrange1 = range1!.substring(
                                          range1!.lastIndexOf(" ") + 1);
                                      print(lastrange1);

                                      String lastrange2 = range2!.substring(
                                          range2!.lastIndexOf(" ") + 1);
                                      print(lastrange2);

                                      if (lastrange1 == "Cr") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r1);
                                      } else if (lastrange1 == "Lac") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r1);
                                      } else if (lastrange1 == "K") {
                                        r1 = int.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r1);
                                      }
                                      if (lastrange2 == "Cr") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r2);
                                      } else if (lastrange2 == "Lac") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r2);
                                      } else if (lastrange2 == "K") {
                                        r2 = int.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r2);
                                      }
                                      if (r1! >= r2!) {
                                        print("Select range1 lessthen range2");
                                        Fluttertoast.showToast(
                                          msg: "Select range1 lessthen range2",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: ColorRes.textGrey,
                                          textColor: Colors.white,
                                          fontSize: 18,
                                        );
                                      } else {
                                        print("Range1 is lessthen range2");
                                        print("$range1 - $range2");
                                        range3 = "$range1" + " to " + "$range2";
                                        Get.offAll(() => InterSelectionScreen(
                                              selectProperyRange:
                                                  currSelectRate,
                                              selectProperyRange2:
                                                  currSelectRate2,
                                            ));
                                      }
                                    });
                                    //Get.offAll(()=>InterSelectionScreen(selectProperyRange: currSelectRate,selectProperyRange2: currSelectRate2,));

                                  } else {
                                    range1 =
                                        widget.rangeListWidgets[0].toString();
                                    range2 =
                                        widget.rangeListWidgets2[0].toString();
                                    setState(() {
                                      selectedMinPrize = range1;
                                      selectedMaxPrize = range2;
                                      String lastrange1 = range1!.substring(
                                          range1!.lastIndexOf(" ") + 1);
                                      print(lastrange1);

                                      String lastrange2 = range2!.substring(
                                          range2!.lastIndexOf(" ") + 1);
                                      print(lastrange2);

                                      if (lastrange1 == "Cr") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r1);
                                      } else if (lastrange1 == "Lac") {
                                        r1 = double.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r1);
                                      } else if (lastrange1 == "K") {
                                        r1 = int.parse(range1
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r1);
                                      }
                                      if (lastrange2 == "Cr") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            10000000;
                                        print(r2);
                                      } else if (lastrange2 == "Lac") {
                                        r2 = double.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            100000;
                                        print(r2);
                                      } else if (lastrange2 == "K") {
                                        r2 = int.parse(range2
                                                .toString()
                                                .split(" ")
                                                .first
                                                .toString()) *
                                            1000;
                                        print(r2);
                                      }
                                      if (r1! >= r2!) {
                                        print("Select range1 lessthen range2");
                                        Fluttertoast.showToast(
                                          msg: "Select range1 lessthen range2",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: ColorRes.textGrey,
                                          textColor: Colors.white,
                                          fontSize: 18,
                                        );
                                      } else {
                                        print("Range1 is lessthen range2");
                                        print("$range1 - $range2");
                                        range3 = "$range1" + " to " + "$range2";
                                        Get.offAll(() => InterSelectionScreen(
                                              selectProperyRange:
                                                  currSelectRate,
                                              selectProperyRange2:
                                                  currSelectRate2,
                                            ));
                                      }
                                    });
                                    //Get.offAll(()=>InterSelectionScreen(selectProperyRange: currSelectRate,selectProperyRange2: currSelectRate2,));
                                    showPop = true;
                                  }
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove("minPrice");
                                  prefs.remove("maxPrice");
                                  print("MIN PRICE IN RANGE SCREEN =====>  " +
                                      range1.toString());
                                  prefs.setString(
                                      "minPrice", range1.toString());
                                  print("MAX PRICE IN RANGE SCREEN ====>  " +
                                      range2.toString());
                                  prefs.setString(
                                      "maxPrice", range2.toString());
                                  FirebaseAnalyticsService.sendAnalyticsEvent2(
                                      Str.cPreferenceAdd,
                                      Str.click,
                                      Str.lPreferences_price_selected);
                                },
                                child: CustomButton.myButton(AppRes.done),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: ColorRes.raioContainer,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: Get.height / 6 - 10,
                    child: Container(
                      width: Get.width,
                      // decoration: BoxDecoration(border: Border.all(width: 1)),
                      height: 0.1,
                      child: Divider(
                        thickness: 1,
                        color: ColorRes.white.withOpacity(0.2),
                      ),
                    )),
                Positioned(
                    top: Get.height / 5 + 10,
                    child: Container(
                      width: Get.width,
                      // decoration: BoxDecoration(border: Border.all(width: 1)),
                      height: 0.1,
                      child: Divider(
                        thickness: 1,
                        color: ColorRes.white.withOpacity(0.2),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    left: Get.width / 2.3,
                    top: Get.height / 6,
                    child: Text(
                      "to",
                      style: AppTextStyle(textColor: ColorRes.white, size: 20),
                    )),
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllerRange!.dispose();
    super.dispose();
  }
}
