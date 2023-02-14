import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class PersonalPropertyViewModel extends BaseViewModel {
  ScrollController? pageController;
  bool openBottomShit = false;

  void init() {
    pageController = ScrollController()..addListener(handleScrolling);
    tabTitle = tabbarList[0].toString();
  }

  handleScrolling() {
    /*var isEnd = (pageController!.offset >= pageController!.position.maxScrollExtent) &&
        !pageController!.position.outOfRange &&
        (pageController!.position.axisDirection == AxisDirection.down);*/

    if (openBottomShit == false) {
      openBottomShit = true;
      Get.bottomSheet(Container(
        width: Get.width,
        height: Get.height / 2,
        decoration: BoxDecoration(
          color: ColorRes.raioContainer,
        ),
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height / 15,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: tabbarList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        tabTitle = tabbarList[index].toString();
                        notifyListeners();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.center,
                        width: Get.width / 3,
                        // height: Get.,
                        decoration: tabTitle == tabbarList[index].toString()
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: ColorRes.raioContainer,
                                border: Border.all(
                                    color: ColorRes.divider, width: 2.5),
                              )
                            : BoxDecoration(),
                        child: Text(
                          tabbarList[index].toString(),
                          style: AppTextStyle(textColor: ColorRes.white),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: Get.width,
                  // height: Get.height/3,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: tabbarListTitle.length,
                      itemBuilder: (context, index) {
                        //var model;
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
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
                                                tabbarListTitle[index]
                                                    .toString(),
                                                style: AppTextStyle(
                                                    textColor: ColorRes.white),
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
                                            tabbarListSubtitle[index]
                                                .toString(),
                                            style: AppTextStyle(
                                                textColor: ColorRes.white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 2,
                                  width: Get.width,
                                  color: ColorRes.divider,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      )).then((value) {
        openBottomShit = false;
      });
    }
  }

  String? tabTitle;
  List<String> tabbarList = [
    "Details",
    "Amenities(13)",
    "Nearby(3)",
  ];

  List<String> tabbarListTitle = [
    "Floor",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
    "Bedroooms",
  ];
  List<String> tabbarListSubtitle = [
    "14th",
    "4",
    "4",
    "4",
    "4",
    "4",
    "4",
    "4",
    "4",
    "4",
    "4",
  ];
}
