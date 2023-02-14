import 'package:com.propacy.b2c/screen/personal_property_details/personal_property_view_model.dart';
import 'package:com.propacy.b2c/screen/personal_property_details/widgets/widgets.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class PersonalPropertyDetailsScreen extends StatefulWidget {
  @override
  _PersonalPropertyDetailsScreenState createState() =>
      _PersonalPropertyDetailsScreenState();
}

class _PersonalPropertyDetailsScreenState
    extends State<PersonalPropertyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonalPropertyViewModel>.reactive(
        viewModelBuilder: () => PersonalPropertyViewModel(),
        onModelReady: (model) {
          model.init();
        },
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorRes.raioContainer,
              body: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    height: Get.height / 12,
                    color: ColorRes.black,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Stack(
                        children: [
                          Row(
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
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: Get.width / 8),
                                  Text(
                                    "Lodha bel air",
                                    style: AppTextStyle(
                                        textColor: Colors.white,
                                        size: 20,
                                        weight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/icons/notification.png",
                                      color: Colors.white,
                                      fit: BoxFit.fill,
                                    ),
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 5,
                            child: Container(
                              alignment: Alignment.center,
                              // child: Image.asset("assets/icons/notification.png",color: Colors.white ,fit: BoxFit.fill,),
                              width: 15,
                              height: 15,
                              child: Text(
                                "1",
                                style: AppTextStyle(
                                    textColor: ColorRes.white, size: 12),
                              ),
                              decoration: BoxDecoration(
                                color: ColorRes.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    // fit: StackFit.expand,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/image/propertyHome.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: Get.width,
                            // height: Get.height/10,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "96% Match",
                                    style: AppTextStyle(
                                        textColor: Colors.green,
                                        size: 16,
                                        weight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Lodha bel air",
                                    style: AppTextStyle(
                                        textColor: Colors.white,
                                        size: 16,
                                        weight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "3 bhk . 1120 area Patel street jogeshvari  E",
                                    style: AppTextStyle(
                                        textColor: Colors.white,
                                        size: 16,
                                        weight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          Divider(thickness: 2, color: ColorRes.divider),
                          SizedBox(height: 10),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/write.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(
                                        AppRes.propertyheighlight,
                                        style: AppTextStyle(
                                            textColor: Color(0xFfFFC776),
                                            size: 16,
                                            weight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    AppRes.subtitlePropertyDetails,
                                    style: AppTextStyle(
                                        textColor: ColorRes.white,
                                        size: 16,
                                        weight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            alignment: Alignment.center,
                            width: Get.width,
                            height: Get.height / 16,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: ColorRes.btnBg),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/icons/save.png",
                                    color: ColorRes.btnBg,
                                    fit: BoxFit.fill,
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Shortlist",
                                  style: AppTextStyle(
                                      textColor: ColorRes.btnBg,
                                      size: 16,
                                      weight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: Get.width,
                            height: Get.height / 15,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: model.tabbarList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      model.tabTitle =
                                          model.tabbarList[index].toString();
                                      model.notifyListeners();
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      alignment: Alignment.center,
                                      width: Get.width / 3,
                                      // height: Get.,
                                      decoration: model.tabTitle ==
                                              model.tabbarList[index].toString()
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: ColorRes.raioContainer,
                                              border: Border.all(
                                                  color: ColorRes.divider,
                                                  width: 2.5),
                                            )
                                          : BoxDecoration(),
                                      child: Text(
                                        model.tabbarList[index].toString(),
                                        style: AppTextStyle(
                                            textColor: ColorRes.white),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 14),
                            width: Get.width,
                            height: Get.height / 20,
                            child: ListView.builder(
                                controller: model.pageController,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: model.tabbarListTitle.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.home,
                                                          color: ColorRes.white,
                                                          size: 30,
                                                        ),
                                                        Text(
                                                          model.tabbarListTitle[
                                                                  index]
                                                              .toString(),
                                                          style: AppTextStyle(
                                                              textColor:
                                                                  ColorRes
                                                                      .white),
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
                                                // height: 40,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.tabbarListSubtitle[
                                                              index]
                                                          .toString(),
                                                      style: AppTextStyle(
                                                          textColor:
                                                              ColorRes.white),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // Container(
                                          //   height: 2,
                                          //   width: Get.width,
                                          //   color: ColorRes.raioContainer,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      // Container(
                      //   width: Get.width,
                      //   height: 500,
                      //   child: DraggableScrollableSheet(
                      //     initialChildSize: 0.3,
                      //     minChildSize: 0.2,
                      //     maxChildSize:1.0,
                      //     builder: (BuildContext context, ScrollController scrollController) {
                      //       return Container(
                      //         height:100,
                      //         color: Colors.lightGreen[100],
                      //         child: ListView(
                      //           controller: scrollController,
                      //           children: [
                      //             ListTile(
                      //               title: Text(
                      //                 "NAME",
                      //               ),
                      //               subtitle: Text(
                      //                 "FAMILY",
                      //               ),
                      //             ),
                      //             ListTile(
                      //               title: Text(
                      //                 "FAMILY",
                      //               ),
                      //               subtitle: Text(
                      //                 "FAMILY",
                      //               ),
                      //             ),
                      //             ListTile(
                      //               title: Text(
                      //                 "LIFESPAN",
                      //               ),
                      //               subtitle: Text(
                      //                 "FAMILY",
                      //               ),
                      //             ),
                      //             ListTile(
                      //               title: Text(
                      //                 "WEIGHT",
                      //               ),
                      //               subtitle: Text(
                      //                 "FAMILY",
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
