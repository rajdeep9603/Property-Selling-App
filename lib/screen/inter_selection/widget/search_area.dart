import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/search_area/search_select_area.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_loader_new.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SearchArea extends StatefulWidget {
  GetZonesModel? zoneModel;

  SearchArea({this.zoneModel});

  @override
  _SearchAreaState createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
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

  @override
  void initState() {
    if (widget.zoneModel!.data == null) {
      Fluttertoast.showToast(
          msg: "Zones Not found",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      zoneExpansionList = widget.zoneModel!.data!.zones![2].groups;
    }

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.zoneModel);
    return widget.zoneModel!.data == null
        ? Positioned(
            bottom: 0,
            child: Container(
              height: Get.height / 2 - 32,
              // padding: EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Data Not Found",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => InterSelectionScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      height: Get.height / 15,
                      width: Get.width - 20,
                      decoration: BoxDecoration(
                          // / border: Border.all(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: ColorRes.btnBg),
                      child: Text(
                        "Done",
                        style: AppTextStyle(
                            textColor: ColorRes.darkBlue,
                            size: 16,
                            weight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ))
        : Positioned(
            bottom: 0,
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              // height: Get.height * 0.4 + 32,
              height: Get.height / 2 - 32,
              width: Get.width,
              color: ColorRes.containerbgColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            AppRes.searchAreaTitle,
                            style: AppTextStyle(
                                textColor: ColorRes.white, size: 14),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          searchFeild(widget.zoneModel!),
                          SizedBox(
                            height: 10,
                          ),
                          widget.zoneModel!.data == null
                              // ? CircularProgressIndicator()
                              ? commonLoader()
                              : areaTabChange(zoneModel: widget.zoneModel),
                          SizedBox(
                            height: 10,
                          ),
                          zonesCome == true
                              ? checkMultipleArea(
                                  zoneExpansionList: zoneExpansionList)
                              : Container(),
                          //checkMultipleArea(zoneExpansionList:zoneExpansionList),
                          // checkMultipleArea(zoneExpansionList:zoneExpansionList),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: ColorRes.raioContainer,
                      thickness: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        var newbool1 = isChecked.contains(true);
                        newbool1 == false
                            ? Get.snackbar(
                                "Please select any one location", "Error!",
                                backgroundColor: ColorRes.black,
                                colorText: ColorRes.white,
                                snackPosition: SnackPosition.BOTTOM,
                                padding: EdgeInsets.all(5))
                            : Container();
                        // isChecked.forEach((element){
                        //   checkboolList!.add(element);
                        // });
                        // var bool = checkboolList!.contains(false);

                        // checkBoolListSize!.length == 0 ? Get.snackbar("Please select any one location", "Error!",backgroundColor: ColorRes.black,colorText: ColorRes.white,snackPosition:SnackPosition.BOTTOM,padding: EdgeInsets.all(5)):Container();
                        setState(() {});
                        // isChecked.length == 0 || isChecked == null || isChecked.length == null ?
                        // bool == false ?  Get.snackbar("Please select any one!", "Please attention here",colorText: ColorRes.red,backgroundColor: ColorRes.white.withOpacity(0.5)) : Container();
                        // Get.back();
                        Get.offAll(() => InterSelectionScreen());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(top: 15, right: 10, left: 10),
                        height: Get.height / 15,
                        width: Get.width - 20,
                        decoration: BoxDecoration(
                            // / border: Border.all(width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: ColorRes.btnBg),
                        child: Text(
                          "Done",
                          style: AppTextStyle(
                              textColor: ColorRes.darkBlue,
                              size: 16,
                              weight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Divider(
                      color: ColorRes.raioContainer,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget searchFeild(GetZonesModel zoneModel) {
    return InkWell(
      onTap: () {
        Get.to(() => SearchSelectAreaScreen(
              zoneModel: zoneModel,
            ));
      },
      child: Container(
        width: Get.width,
        height: Get.height / 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorRes.raioContainer),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(Icons.search, color: ColorRes.raioContainer),
              SizedBox(
                width: 10,
              ),
              Text(AppRes.search,
                  style: AppTextStyle(
                      textColor: ColorRes.raioContainer, size: 18)),
            ],
          ),
        ),
      ),
    );
  }

  Widget areaTabChange({GetZonesModel? zoneModel}) {
    print(zoneModel);
    return Container(
      width: Get.width,
      height: Get.height / 22,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: zoneModel!.data!.zones!.length == 0
              ? 0
              : zoneModel.data!.zones!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  zoneExpansionList = zoneModel.data!.zones![index].groups!;
                  checkMultipleArea(zoneExpansionList: zoneExpansionList);
                  zonesCome = true;
                  print(zoneExpansionList);
                  categorySelected = index;
                });

                // title = tabList[index];
              },
              child: Container(
                alignment: Alignment.center,
                decoration: categorySelected == index
                    ? BoxDecoration(
                        color: ColorRes.raioContainer,
                        borderRadius: BorderRadius.circular(20),
                      )
                    : BoxDecoration(),
                width: Get.width / 3.5,
                // height:50,
                child: Text(zoneModel.data!.zones![index].zoneCode.toString(),
                    style: AppTextStyle(textColor: ColorRes.white, size: 15)),
              ),
            );
          }),
    );
  }

  Widget checkMultipleArea({List<Group>? zoneExpansionList}) {
    print(zoneExpansionList!.length.toString());
    print(zoneExpansionList);
    return Container(
      width: Get.width,
      height: Get.height / 7,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount:
              zoneExpansionList.length == 0 ? 0 : zoneExpansionList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                isChecked[index] = !isChecked[index];
                // checkBoolListSize!.add(isChecked[index]);
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
                height: Get.height / 18,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: ColorRes.white)),
                        // child: checkArea == index ? Icon(Icons.check,color: ColorRes.white,size: 18,) : Container(),
                        child: isChecked[index] == true
                            ? Icon(
                                Icons.check,
                                color: ColorRes.white,
                                size: 18,
                              )
                            : Container(),
                      ),
                      SizedBox(width: 15),
                      Text(zoneExpansionList[index].name.toString(),
                          style: AppTextStyle(
                              textColor: ColorRes.white, size: 14)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
