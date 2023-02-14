import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/search_area.dart';
import 'package:com.propacy.b2c/screen/search_area/search_area_view_model.dart';
import 'package:com.propacy.b2c/screen/search_area/search_select_area.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_textfield.dart';
import 'package:com.propacy.b2c/utils/custom_button.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

Widget searchFeild(SearchAreaViewModel model, GetZonesModel? zoneModel) {
  return Container(
    width: Get.width,
    height: Get.height / 14,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: ColorRes.raioContainer),
      color: Colors.transparent,
    ),
    child: commonTextFormField(
        hintText: "Search",
        hintStyle: AppTextStyle(textColor: ColorRes.white),
        onChangeValue: (searchText) {
          if (model.searchController.text.isEmpty) {
            model.filterList!.clear();
            areaList = [];

            model.getZones!.forEach((element) {
              List<List<bool>> l = [];
              element.groups!.forEach((ele) {
                List<bool> m = [];
                ele.areas!.forEach((e) {
                  if (loginHasPref == true) {
                    print("AB2 " + ab2.toString());
                    if (ab2
                        .toString()
                        .toLowerCase()
                        .contains(e.name.toString().toLowerCase())) {
                      m.add(true);
                      displayLocality.add(e.name.toString());
                      print("ADD TRUE " + e.name.toString());
                      print("LOGIN AREA" + ab.toString());
                    } else {
                      m.add(false);
                      print("ADD FALSE " + e.name.toString());
                    }
                  } else {
                    print("AB " + ab.toString());
                    if (ab
                        .toString()
                        .toLowerCase()
                        .contains(e.name.toString().toLowerCase())) {
                      m.add(true);
                      print("ADD TRUE " + e.name.toString());
                      displayLocality.add(e.name.toString());
                    } else {
                      m.add(false);
                      print("ADD FALSE " + e.name.toString());
                    }
                  }
                });
                l.add(m);
              });
              areaList.add(l);
            });

            model.groupClick = [];
            model.notifyListeners();
          }
          model.groupSearchRes!.clear();
          model.filterList!.clear();
          model.groupClick = [];
          model.key.clear();
          print(model.zoneExpansionList);

          if (model.searchController.text.isNotEmpty) {
            model.zoneExpansionList!.forEach((element) {
              if (element.name!.toString().toLowerCase().contains(
                  model.searchController.text.toString().toLowerCase())) {
                model.grpCheck.contains(element.name);

                model.filterList!.add(element);
                model.key = model.grpClick.keys.toList();
                if (model.searchController.text.isNotEmpty) {
                  if (model.key.length > 0) {
                    for (int i = 0; i < model.key.length; i++) {
                      if (model.key[i] != element.name) {
                        model.grpClick.addAll({element.name!: false});
                      }
                    }
                  } else {
                    model.grpClick.addAll({element.name!: false});
                  }
                }

                model.groupSearchRes!.add(element.name!);
              }
              element.areas!.forEach((el) {
                if (el.name!.toLowerCase().contains(
                    model.searchController.text.toString().toLowerCase())) {
                  model.filterList!.add(element);

                  if (model.key.length > 0) {
                    for (int i = 0; i < model.key.length; i++) {
                      if (model.key[i] != element.name) {
                        model.grpClick.addAll({element.name!: false});
                      }
                    }
                  } else {
                    model.grpClick.addAll({element.name!: false});
                  }
                }
              });

              model.filterList = model.filterList!.toSet().toList();
              List<List<bool>> l1 = [];
              model.filterList!.forEach((element) {
                List<bool> l2 = [];
                element.areas!.forEach((e1) {
                  if (loginHasPref == true) {
                    print("AB2 " + ab2.toString());
                    if (ab2
                        .toString()
                        .toLowerCase()
                        .contains(e1.name.toString().toLowerCase())) {
                      l2.add(true);
                      displayLocality.add(e1.name.toString());
                      print("ADD TRUE " + e1.name.toString());
                      print("LOGIN AREA" + ab2.toString());
                    } else {
                      l2.add(false);
                      print("ADD FALSE " + e1.name.toString());
                    }
                  } else {
                    print("AB " + ab.toString());
                    if (ab
                        .toString()
                        .toLowerCase()
                        .contains(e1.name.toString().toLowerCase())) {
                      l2.add(true);
                      print("ADD TRUE " + e1.name.toString());
                      displayLocality.add(e1.name.toString());
                    } else {
                      l2.add(false);
                      print("ADD FALSE " + e1.name.toString());
                    }
                  }
                  //l2.add(false);
                });
                l1.add(l2);
              });
              areaList[model.categorySelected] = l1;
            });
          }

          searchText = searchText.toLowerCase();

          model.getZones!.where((z) {
            var zonecode = z.zoneCode!.toLowerCase();
            if (zonecode.contains(indexTab!) == true) {
              model.getZonesDisplay = z.groups!.where((element) {
                if (element.name!.contains(searchText)) {
                  print(true);
                  return true;
                }
                return false;
              }).toList();
            }
            return false;
          });
          model.notifyListeners();
        },
        controller: model.searchController,
        preicon: Icon(
          Icons.search,
          color: ColorRes.raioContainer,
        )),
  );
}

Widget areaTabChange(SearchAreaViewModel model, GetZonesModel zoneModel) {
  return Container(
    width: Get.width,
    height: Get.height / 16,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: zoneModel.data!.zones!.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              print("tap");
              model.groupSearchRes!.clear();
              indexTab = zoneModel.data!.zones![index].zoneCode.toString();

              model.categorySelected = index;
              model.zoneExpansionList = zoneModel.data!.zones![index].groups;
              model.groupClick = [];
              model.zoneExpansionList!.forEach((element) {
                model.groupClick.add(false);
              });

              model.initGroup.clear();
              model.filterList1!.clear();
              model.filterList!.clear();
              model.zoneExpansionList!.forEach((element) {
                model.initGroup.add(element.name!);
              });
              if (model.searchController.text.isNotEmpty) {
                model.zoneExpansionList!.forEach((element) {
                  if (element.name!
                      .toLowerCase()
                      .contains(model.searchController.text.toLowerCase())) {
                    model.groupSearchRes!.add(element.name!);
                    model.filterList1!.add(element);
                  }
                  element.areas!.forEach((el) {
                    if (el.name!
                        .toLowerCase()
                        .contains(model.searchController.text.toLowerCase())) {
                      model.filterList1!.add(element);
                      if (model.groupSearchRes!.contains(element.name)) {
                        model.groupSearchRes!.remove(element.name);
                        model.groupSearchRes!.add(element.name!);
                      } else {
                        model.groupSearchRes!.add(element.name!);
                      }
                    }
                  });
                });
                model.filterList = model.filterList1!.toSet().toList();
              }
              model.groupSearchRes!.length != 0
                  ? Container(
                      width: Get.width,
                      height: Get.height / 2,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: model.initGroup.length == 0
                              ? 0
                              : model.initGroup.length,
                          // itemCount: model!.searchZone!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (model.map[
                                        model.initGroup[index].toLowerCase()] ==
                                    true) {
                                  model.map[model.initGroup[index]
                                      .toLowerCase()] = false;
                                } else {
                                  model.map[model.initGroup[index]
                                      .toLowerCase()] = true;
                                }

                                model.isChecked[index] =
                                    !model.isChecked[index];

                                model.checkArea = index;
                                model.notifyListeners();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: model.checkArea == index
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: ColorRes.white)),
                                            child: model.map[model
                                                        .initGroup[index]
                                                        .toLowerCase()] ==
                                                    true
                                                ? Icon(
                                                    Icons.check,
                                                    color: ColorRes.white,
                                                    size: 18,
                                                  )
                                                : Container(),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                              model.initGroup[index].toString(),
                                              style: AppTextStyle(
                                                  textColor: ColorRes.white,
                                                  size: 14)),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          model.areaCome = true;

                                          model.zoneExpansionList!
                                              .forEach((element) {
                                            if (model.initGroup[index]
                                                    .toString() ==
                                                element.name.toString()) {
                                              model.areas = element.areas;
                                            }
                                          });
                                          model.areas = model
                                              .zoneExpansionList![index].areas;

                                          print(model.areas.toString());
                                          print(model.areas!.length);

                                          model.on3ContainerTap = true;
                                          model.areaTitle = model
                                              .zoneExpansionList![index].name
                                              .toString();
                                          model.notifyListeners();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              // color: Colors.white,
                                              ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 3,
                                                height: 3,
                                                color: ColorRes.red,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                width: 3,
                                                height: 3,
                                                color: ColorRes.white,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                width: 3,
                                                height: 3,
                                                color: ColorRes.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : Container(
                      width: Get.width,
                      height: Get.height / 2,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: model.initGroup.length == 0
                              ? 0
                              : model.initGroup.length,
                          // itemCount: model!.searchZone!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (model.map[
                                        model.initGroup[index].toLowerCase()] ==
                                    true) {
                                  model.map[model.initGroup[index]
                                      .toLowerCase()] = false;
                                } else {
                                  model.map[model.initGroup[index]
                                      .toLowerCase()] = true;
                                }

                                model.isChecked[index] =
                                    !model.isChecked[index];

                                model.checkArea = index;
                                model.notifyListeners();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: model.checkArea == index
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: ColorRes.white)),
                                            child: model.map[model
                                                        .initGroup[index]
                                                        .toLowerCase()] ==
                                                    true
                                                ? Icon(
                                                    Icons.check,
                                                    color: ColorRes.white,
                                                    size: 18,
                                                  )
                                                : Container(),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                              model.initGroup[index].toString(),
                                              style: AppTextStyle(
                                                  textColor: ColorRes.white,
                                                  size: 14)),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          model.areaCome = true;
                                          model.zoneExpansionList!
                                              .forEach((element) {
                                            if (model.initGroup[index]
                                                    .toString() ==
                                                element.name.toString()) {
                                              model.areas = element.areas;
                                            }
                                          });
                                          model.areas = model
                                              .zoneExpansionList![index].areas;

                                          print(model.areas.toString());
                                          print(model.areas!.length);

                                          model.on3ContainerTap = true;
                                          model.areaTitle = model
                                              .zoneExpansionList![index].name
                                              .toString();
                                          model.notifyListeners();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          // width: 4,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              // color: Colors.white,
                                              ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 3,
                                                height: 3,
                                                color: ColorRes.white,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                width: 3,
                                                height: 3,
                                                color: ColorRes.white,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                width: 3,
                                                height: 3,
                                                color: ColorRes.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );

              model.zonesCome = true;

              print(model.zoneExpansionList);

              model.notifyListeners();
            },
            child: Container(
              alignment: Alignment.center,
              decoration: model.categorySelected == index
                  ? BoxDecoration(
                      color: ColorRes.raioContainer,
                      borderRadius: BorderRadius.circular(20),
                    )
                  : BoxDecoration(),
              width: Get.width / 3.5,
              // height: Get.height/20,
              child: Text(zoneModel.data!.zones![index].zoneCode.toString(),
                  style: AppTextStyle(textColor: ColorRes.white, size: 14)),
            ),
          );
        }),
  );
}

Widget checkMultipleArea(
    {SearchAreaViewModel? model,
    List<Group>? zoneExpansion,
    int? ind,
    List<String>? initGroup}) {
  return Container(
    width: Get.width,
    child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: zoneExpansion!.length,
        itemBuilder: (context, index) {
          if (areaList[model!.categorySelected][index].contains(false))
            lockMap[zoneExpansion[index].name!] = false;
          else {
            lockMap[zoneExpansion[index].name!] = true;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_location_dropdown);
                  print("Full Row Tap");
                  if (model.grpClick[zoneExpansion[index].name] == true) {
                    model.grpClick[zoneExpansion[index].name!] = false;
                  } else {
                    model.grpClick[zoneExpansion[index].name!] = true;
                  }

                  model.areaCome = true;
                  zoneExpansion.forEach((element) {
                    if (zoneExpansion[index].name!.toString() ==
                        element.name.toString()) {
                      model.areas = element.areas;
                    }
                  });
                  model.areas = zoneExpansion[index].areas;
                  print(model.areas.toString());
                  print(model.areas!.length);
                  model.on3ContainerTap = true;
                  model.areaTitle =
                      model.zoneExpansionList![index].name.toString();
                  model.notifyListeners();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.center,
                  decoration:areaList[model.categorySelected][index].contains(true)
                      ? BoxDecoration(
                          color: ColorRes.raioContainer,
                          borderRadius: BorderRadius.circular(20),
                        )
                      : BoxDecoration(),
                  width: Get.width,
                  height: Get.height / 15,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("CHECK BOX TAP OF FULL ROW");
                                FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_location_selected);
                                print(zoneExpansion[index].name!);
                                print(lockMap[zoneExpansion[index].name!]);
                                if (lockMap[zoneExpansion[index].name!] ==
                                    true) {
                                  lockMap[zoneExpansion[index].name!] = false;
                                  for (int i = 0;
                                      i <
                                          areaList[model.categorySelected]
                                                  [index]
                                              .length;
                                      i++) {
                                    areaList[model.categorySelected][index][i] =
                                        false;
                                  }
                                  zoneExpansion.forEach((element) {
                                    element.areas!.forEach((e1) {
                                      if (element.name!.toLowerCase() ==
                                          zoneExpansion[index]
                                              .name!
                                              .toLowerCase()) {
                                        displayLocality
                                            .remove(e1.name.toString());
                                        if (loginHasPref == true)
                                          ab2.remove(e1.name.toString());
                                        else
                                          ab.remove(e1.name.toString());
                                        print("remove$displayLocality");
                                      }
                                    });
                                  });
                                } else {
                                  lockMap[zoneExpansion[index].name!] = true;
                                  for (int i = 0;
                                      i <
                                          areaList[model.categorySelected]
                                                  [index]
                                              .length;
                                      i++) {
                                    areaList[model.categorySelected][index][i] =
                                        true;
                                  }
                                  zoneExpansion.forEach((element) {
                                    element.areas!.forEach((e1) {
                                      if (element.name!.toLowerCase() ==
                                          zoneExpansion[index]
                                              .name!
                                              .toLowerCase()) {
                                        displayLocality.add(e1.name.toString());
                                        if (loginHasPref == true)
                                          ab2.add(e1.name.toString());
                                        else
                                          ab.add(e1.name.toString());
                                        print("DISPLAY LOCALITY " +
                                            displayLocality.toString());
                                        print("add+$displayLocality");
                                      }
                                    });
                                  });
                                }
                                displayLocality =
                                    displayLocality.toSet().toList();
                                if (loginHasPref == true)
                                  ab2 = ab2.toSet().toList();
                                else
                                  ab = ab.toSet().toList();
                                print(displayLocality);
                                print("abList");
                                print(ab);
                                print(ab2);
                                model.isChecked[index] =
                                    !model.isChecked[index];
                                model.checkArea = index;
                                model.notifyListeners();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 21,
                                height: 21,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: ColorRes.white)),
                                child:
                                    lockMap[zoneExpansion[index].name!] == true
                                        ? Icon(
                                            Icons.check,
                                            color: ColorRes.white,
                                            size: 18,
                                          )
                                        : Container(),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Text(zoneExpansion[index].name.toString(),
                                    style: AppTextStyle(
                                        textColor: ColorRes.white, size: 14)),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                // width: 4,
                                height: 20,
                                decoration: BoxDecoration(
                                    // color: Colors.white,
                                    ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 3,
                                      height: 3,
                                      color: ColorRes.white,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      width: 3,
                                      height: 3,
                                      color: ColorRes.white,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      width: 3,
                                      height: 3,
                                      color: ColorRes.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              model.grpClick[zoneExpansion[index].name] == true
                  ? Container(
                      padding: EdgeInsets.only(left: 40),
                      margin: EdgeInsets.all(10),
                      width: Get.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: zoneExpansion[index].areas!.length,
                          itemBuilder: (BuildContext context, int ind) {
                            return InkWell(
                              onTap: () {
                                FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lPreferences_location_selected);
                                print("TAP CHECK INNER ROW");
                                print("SUB MAP : " + model.submap.toString());
                                print(areaList[model.categorySelected][index]
                                    [ind]);

                                if (areaList[model.categorySelected][index]
                                        [ind] ==
                                    true) {
                                  areaList[model.categorySelected][index][ind] =
                                      false;
                                  displayLocality.remove(
                                      zoneExpansion[index].areas![ind].name!);
                                  if (loginHasPref == true)
                                    ab2.remove(
                                        zoneExpansion[index].areas![ind].name!);
                                  else
                                    ab.remove(
                                        zoneExpansion[index].areas![ind].name!);
                                  print("remove$displayLocality");
                                } else {
                                  areaList[model.categorySelected][index][ind] =
                                      true;
                                  displayLocality.add(
                                      zoneExpansion[index].areas![ind].name!);
                                  if (loginHasPref == true)
                                    ab2.add(
                                        zoneExpansion[index].areas![ind].name!);
                                  else
                                    ab.add(
                                        zoneExpansion[index].areas![ind].name!);
                                  print("add+$displayLocality");
                                }
                                displayLocality =
                                    displayLocality.toSet().toList();
                                if (loginHasPref == true)
                                  ab2 = ab2.toSet().toList();
                                else
                                  ab = ab.toSet().toList();
                                print(displayLocality);
                                print("abList");
                                print(ab);
                                print(ab2);

                                model.checkArea = index;
                                model.notifyListeners();
                              },
                              child: Container(
                                width: Get.width,
                                height: Get.height / 16,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print("TAP CHECK INNER CHECKBOX");
                                            print("SUB MAP : " +
                                                model.submap.toString());
                                            print(
                                                areaList[model.categorySelected]
                                                    [index][ind]);

                                            if (areaList[model.categorySelected]
                                                    [index][ind] ==
                                                true) {
                                              areaList[model.categorySelected]
                                                  [index][ind] = false;
                                              displayLocality.remove(
                                                  zoneExpansion[index]
                                                      .areas![ind]
                                                      .name!);
                                              if (loginHasPref == true)
                                                ab2.remove(zoneExpansion[index]
                                                    .areas![ind]
                                                    .name!);
                                              else
                                                ab.remove(zoneExpansion[index]
                                                    .areas![ind]
                                                    .name!);
                                              print("remove$displayLocality");
                                            } else {
                                              areaList[model.categorySelected]
                                                  [index][ind] = true;
                                              displayLocality.add(
                                                  zoneExpansion[index]
                                                      .areas![ind]
                                                      .name!);
                                              if (loginHasPref == true)
                                                ab2.add(zoneExpansion[index]
                                                    .areas![ind]
                                                    .name!);
                                              else
                                                ab.add(zoneExpansion[index]
                                                    .areas![ind]
                                                    .name!);
                                              print("add+$displayLocality");
                                            }
                                            displayLocality = displayLocality
                                                .toSet()
                                                .toList();
                                            if (loginHasPref == true)
                                              ab2 = ab2.toSet().toList();
                                            else
                                              ab = ab.toSet().toList();
                                            print("abList");
                                            if (loginHasPref == true)
                                              print(ab2);
                                            else
                                              print(ab);
                                            print(displayLocality);

                                            model.checkArea = index;
                                            model.notifyListeners();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: ColorRes.white)),
                                            child:
                                                areaList[model.categorySelected]
                                                            [index][ind] ==
                                                        true
                                                    ? Icon(
                                                        Icons.check,
                                                        color: ColorRes.white,
                                                        size: 18,
                                                      )
                                                    : Container(),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                            zoneExpansion[index]
                                                .areas![ind]
                                                .name
                                                .toString(),
                                            style: AppTextStyle(
                                                textColor: ColorRes.white,
                                                size: 14)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Container()
            ],
          );
        }),
  );
}

Widget doneStack(SearchAreaViewModel model) {
  return GestureDetector(
    onTap: () {
      print(model.contain);
      areaList = [];
      model.on3ContainerTap = false;
      model.notifyListeners();
      Get.to(() => SearchSelectAreaScreen());
    },
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: Get.height / 14,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: ColorRes.btnBg),
      child: Text(
        "Done",
        style: AppTextStyle(
            textColor: ColorRes.darkBlue, size: 16, weight: FontWeight.w600),
      ),
    ),
  );
}

Widget done(SearchAreaViewModel model, BuildContext context) {
  return GestureDetector(
    onTap: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      showPop = true;
      print(loginHasPref);
      print("loginHasPref");
      model.notifyListeners();
      if (loginHasPref == true) {
        if (ab2.isNotEmpty) {
          if (ab2.length == 1) {
            locOnTap = ab2[0];
          } else {
            locOnTap = "Multiple";
          }
          prefs.setStringList("SelectedArea", ab2);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => InterSelectionScreen()));

          //Get.offAll(() => InterSelectionScreen());
        } else {
          Get.snackbar("Error", "Please Selecte atleast one area");
        }
      } else {
        if (ab.isNotEmpty) {
          if (ab.length == 1) {
            locOnTap = ab[0];
          } else {
            locOnTap = "Multiple";
          }
          prefs.setStringList("SelectedArea", ab);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => InterSelectionScreen()));

          //Get.offAll(() => InterSelectionScreen());
        } else {
          Get.snackbar("Error", "Please Selecte atleast one area");
        }
      }
    },
    child: CustomButton.myButton(AppRes.done),
  );
}
