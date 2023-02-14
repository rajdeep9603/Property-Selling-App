import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/search_area/search_area_view_model.dart';
import 'package:com.propacy.b2c/screen/search_area/widgets/widgets.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_loader_new.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SearchSelectAreaScreen extends StatefulWidget {
  GetZonesModel? zoneModel;

  SearchSelectAreaScreen({this.zoneModel});

  @override
  _SearchSelectAreaScreenState createState() => _SearchSelectAreaScreenState();
}

List<bool> lts1 = [];
List<List<bool>> lts2 = [];

class _SearchSelectAreaScreenState extends State<SearchSelectAreaScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchAreaViewModel>.reactive(
        onModelReady: (model) {
          model.init(widget.zoneModel);
        },
        viewModelBuilder: () => SearchAreaViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorRes.containerbgColor,
              body: model.isBusy
                  ? commonLoader()
                  : widget.zoneModel!.data == null
                      ? Container(
                          height: Get.height,
                          // padding: EdgeInsets.only(top: 60),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: Get.height - 100,
                                width: Get.width,
                                padding: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Data Not Found",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  print("TAP");
                                  // Get.off(() => InterSelectionScreen());
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InterSelectionScreen()));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  alignment: Alignment.center,
                                  height: Get.height / 15,
                                  width: Get.width - 20,
                                  decoration: BoxDecoration(
                                      // / border: Border.all(width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
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
                        )
                      : Container(
                          width: Get.width,
                          height: Get.height,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  // height: Get.height-95,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppRes.searchAreaTitle,
                                              style: AppTextStyle(
                                                  textColor: ColorRes.white,
                                                  size: 14),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            searchFeild(
                                                model, widget.zoneModel),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            areaTabChange(
                                                model, widget.zoneModel!),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            model.filterList!.length > 0 ||
                                                    model.searchController.text
                                                        .isNotEmpty
                                                ? checkMultipleArea(
                                                    model: model,
                                                    zoneExpansion:
                                                        model.filterList,
                                                    ind: model.categorySelected,
                                                    initGroup:
                                                        model.groupSearchRes)
                                                : checkMultipleArea(
                                                    model: model,
                                                    zoneExpansion:
                                                        model.zoneExpansionList,
                                                    ind: model.categorySelected,
                                                    initGroup: model.initGroup),
                                            //  checkMultipleArea(model:model,zoneExpansionList:model.zoneExpansionList,ind:model.categorySelected),

                                            // model.zonesCome == true ? checkMultipleArea1(model:model) : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
              bottomNavigationBar: Container(
                width: Get.width,
                height: 100,
                child: Column(
                  children: [
                    Divider(
                      color: ColorRes.raioContainer,
                      thickness: 2,
                    ),
                    done(model, context),
                    Divider(
                      color: ColorRes.raioContainer,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
