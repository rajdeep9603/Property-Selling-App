import 'package:com.propacy.b2c/screen/property_details/property_details_screen.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_view_model.dart';
import 'package:com.propacy.b2c/screen/shortlist/widgets/widget.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_loader_new.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ShortListScreen extends StatefulWidget {
  @override
  _ShortListScreenState createState() => _ShortListScreenState();
}

class _ShortListScreenState extends State<ShortListScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShortListViewModel>.reactive(
        onModelReady: (model) {
          model.init();
        },
        viewModelBuilder: () => ShortListViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            //bottom navigation bar shortlist
            backgroundColor: ColorRes.containerbgColor,
            // bottomNavigationBar: shortlistBottemBar(
            //   onHomeTap: model.onHomeTap,
            //   onShortListTap: model.onShortListTap,
            //   onSettingTap: model.onSettingTap,
            //   indexBottem: model.indexBottem,
            // ),
            body: model.isBusy
                ? Stack(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Spacer(),
                                Container(
                                  child: Image.asset(
                                    "assets/icons/save.png",
                                    color: Colors.white,
                                    fit: BoxFit.fill,
                                  ),
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  AppRes.shortlisted,
                                  style: AppTextStyle(
                                      textColor: ColorRes.white,
                                      size: 16,
                                      weight: FontWeight.normal),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(
                              color: ColorRes.divider,
                              thickness: 2,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: model.infoList.length == 0
                                    ? Container(
                                        //no shortlist message
                                        height: Get.height - 100,
                                        width: Get.width,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppRes.seems,
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle(
                                                  textColor: ColorRes.textGrey,
                                                  size: 16,
                                                  weight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              AppRes.sHelps,
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle(
                                                  textColor: ColorRes.textGrey,
                                                  size: 14,
                                                  weight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: Get.width,
                                        // height: Get.height/2,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: model.infoList.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  //Get.to(()=>PropertyDetailsScreen(arr:));
                                                  // model.tapping = model.infoList[index]["title"];
                                                  // model.notifyListeners();
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Container(
                                                    // decoration: model.tapping == model.infoList[index]["title"] ? BoxDecoration(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          color:
                                                              ColorRes.divider,
                                                          width: 2),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 10),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            // mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  ClipRRect(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        print(model.infoList[index]["image"]);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        child: Image
                                                                            .network(
                                                                          model
                                                                              .infoList[index]["image"]
                                                                              .toString(),
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                        width:
                                                                            Get.width /
                                                                                4,
                                                                        height:
                                                                            Get.height /
                                                                                7,
                                                                      ),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                ],
                                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                              ),
                                                              // SizedBox(width: 10),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [

                                                                  Text(
                                                                    model
                                                                        .infoList[
                                                                            index]
                                                                            [
                                                                            "title"]
                                                                        .toString(),
                                                                    style: AppTextStyle(
                                                                        textColor:
                                                                            ColorRes
                                                                                .white,
                                                                        size:
                                                                            14,
                                                                        weight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          3),
                                                                  Text(
                                                                    model
                                                                        .infoList[
                                                                            index]
                                                                            [
                                                                            "sub"]
                                                                        .toString()
                                                                        .toString(),
                                                                    style: AppTextStyle(
                                                                        textColor:
                                                                            ColorRes
                                                                                .white,
                                                                        size:
                                                                            16,
                                                                        weight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          3),
                                                                  Text(model
                                                                      .infoList[
                                                                          index]
                                                                          [
                                                                          "bhk"]
                                                                      .toString()),
                                                                  SizedBox(
                                                                      height:
                                                                          3),
                                                                  Text(model
                                                                      .infoList[
                                                                          index]
                                                                          [
                                                                          "area"]
                                                                      .toString()),
                                                                  SizedBox(
                                                                      height:
                                                                          3),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Container(
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/icons/save.png",
                                                                        color: ColorRes
                                                                            .white,
                                                                      ),
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    width: 50,
                                                                    height: 45,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      color: ColorRes
                                                                          .raioContainer,
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                              // SizedBox(width: 0),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        // model.tapping == model.infoList[index]["title"] ? Container(
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorRes
                                                                .raioContainer,
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15)),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        7),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/icons/men.png",
                                                                        color: ColorRes
                                                                            .shortlist,
                                                                      ),
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Center(
                                                                            child:
                                                                                Text(
                                                                          "Visit scheduled",
                                                                          style: AppTextStyle(
                                                                              textColor: ColorRes.shortlist,
                                                                              size: 14,
                                                                              weight: FontWeight.w700),
                                                                        )),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Center(
                                                                            child:
                                                                                Text(
                                                                          "29-02-2021",
                                                                          style: AppTextStyle(
                                                                              textColor: ColorRes.shortlist,
                                                                              size: 14,
                                                                              weight: FontWeight.w700),
                                                                        )),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            "View",
                                                                            style: AppTextStyle(
                                                                                textColor: ColorRes.shortlist,
                                                                                size: 14,
                                                                                weight: FontWeight.w700),
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.transparent,
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              border: Border.all(color: ColorRes.shortlist)),
                                                                          width:
                                                                              Get.width / 4,
                                                                          height:
                                                                              40,
                                                                          alignment:
                                                                              Alignment.center,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          child: Container(
                              width: Get.width,
                              height: Get.height,
                              color: ColorRes.black.withOpacity(0.5),
                              // child: Center(
                              //   child: CircularProgressIndicator(),
                              // ),
                              child: commonLoader()))
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: Get.height / 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Container(
                            child: Image.asset(
                              "assets/icons/save.png",
                              color: Colors.white,
                            ),
                            width: 21,
                            height: 21,
                          ),
                          SizedBox(width: 5),
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              AppRes.shortlisted,
                              style: AppTextStyle(
                                  textColor: ColorRes.white,
                                  size: 16,
                                  weight: FontWeight.normal),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(
                        color: ColorRes.divider,
                        thickness: 2,
                      ),
                      Expanded(
                        child: model.errorText != ''
                            ? Center(
                                //no shortlist message
                                child: Container(
                                  //no shortlist message
                                  height: Get.height - 100,
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppRes.seems,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle(
                                            textColor: ColorRes.textGrey,
                                            size: 14,
                                            weight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        AppRes.sHelps,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle(
                                            textColor: ColorRes.textGrey,
                                            size: 14,
                                            weight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                child: Container(
                                  width: Get.width,
                                  // height: Get.height/2,
                                  child: ListView.builder(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: model.shortListModel.data !=
                                              null
                                          ? model.shortListModel.data!.length
                                          : 0,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            model.details = model
                                                .shortListModel.data![index];
                                            // setState(() {});
                                            //Get.back(result: model.details);
                                            var result = await Get.to(
                                                () => PropertyDetailsScreen(
                                                      fromVideo: false,
                                                      arr: model.shortListModel
                                                          .data![index],
                                                      pId: model.shortListModel
                                                          .data![index].id,
                                                    ));
                                            if (result == true) {
                                              model.init();
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            child: InkWell(
                                              onTap: () async {
                                                model.details = model
                                                    .shortListModel
                                                    .data![index];
                                                // setState(() {});
                                                //Get.back(result: model.details);
                                                var result = await Get.to(
                                                    () => PropertyDetailsScreen(
                                                          fromVideo: false,
                                                          arr: model
                                                              .shortListModel
                                                              .data![index],
                                                          pId: model
                                                              .shortListModel
                                                              .data![index]
                                                              .id,
                                                        ));
                                                if (result == true) {
                                                  model.init();
                                                }

                                                //
                                                // Get.to(() => PropertyDetailsScreen(
                                                //   arr: model.details,
                                                // ));

                                                // model.tapping = model.infoList[index]["title"];
                                                // model.notifyListeners();
                                              },
                                              child: InkWell(
                                                onTap: () async {
                                                  model.details = model
                                                      .shortListModel
                                                      .data![index];
                                                  // setState(() {});
                                                  //Get.back(result: model.details);
                                                  var result = await Get.to(
                                                      () =>
                                                          PropertyDetailsScreen(
                                                            fromVideo: false,
                                                            arr: model
                                                                .shortListModel
                                                                .data![index],
                                                            pId: model
                                                                .shortListModel
                                                                .data![index]
                                                                .id,
                                                          ));
                                                  if (result == true) {
                                                    model.init();
                                                  }
                                                },
                                                child: Container(
                                                  // decoration: model.tapping == model.infoList[index]["title"] ? BoxDecoration(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: ColorRes.divider,
                                                        width: 2),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 12,
                                                                vertical: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          // mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                ClipRRect(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      print(model
                                                                          .shortListModel
                                                                          .data![
                                                                              index]
                                                                          .images![
                                                                              index]
                                                                          .link);
                                                                      model.details = model
                                                                          .shortListModel
                                                                          .data![index];
                                                                      // setState(() {});
                                                                      //Get.back(result: model.details);
                                                                      var result =
                                                                          await Get.to(() =>
                                                                              PropertyDetailsScreen(
                                                                                fromVideo: false,
                                                                                arr: model.shortListModel.data![index],
                                                                                pId: model.shortListModel.data![index].id,
                                                                              ));
                                                                      if (result ==
                                                                          true) {
                                                                        model
                                                                            .init();
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(

                                                                          child: model.shortListModel.data![index].images!.length == 0
                                                                          ?Image.asset("assets/image/foryouImage.png",/*fit: BoxFit.cover,*/)
                                                                          :Image.network( model.shortListModel.data![index].images![0].link.toString(),fit: BoxFit.cover,),
                                                                      // child: Image
                                                                      //     .network(
                                                                      //   model.shortListModel.data![index].images!.length ==
                                                                      //           0
                                                                      //       ? "https://www.lg.com/uk/images/microsite/tonefreeapp/2021/AV-TONEFree-01-App-Minipage-Desktop.jpg"
                                                                      //       : model.shortListModel.data![index].images![0].link.toString(),
                                                                      //   fit: BoxFit
                                                                      //       .cover,
                                                                      // ),
                                                                      width:
                                                                          Get.width /
                                                                              4,
                                                                      height:
                                                                          Get.height /
                                                                              7,
                                                                    ),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                              ],
                                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                                            ),
                                                            SizedBox(width: 20),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                /* Text(
                                                                  "100% Match",
                                                                  style: AppTextStyle(
                                                                      textColor:
                                                                          Colors
                                                                              .green,
                                                                      size: 14,
                                                                      weight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),*/
                                                                Container(
                                                                  width:Get.width-160,
                                                                  // decoration: BoxDecoration(
                                                                  //   border: Border.all(width: 2)
                                                                  // ),
                                                                  child: Text(
                                                                    model
                                                                        .shortListModel
                                                                        .data![
                                                                            index]
                                                                        .title
                                                                        .toString(),
                                                                    style: AppTextStyle(
                                                                        textColor:
                                                                            ColorRes
                                                                                .white,
                                                                        size: 16,
                                                                        weight: FontWeight
                                                                            .bold),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                                // SizedBox(height:3),
                                                                Text(
                                                                  model
                                                                      .shortListModel
                                                                      .data![
                                                                          index]
                                                                      .city
                                                                      .toString(),
                                                                  style: AppTextStyle(
                                                                      textColor: ColorRes
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8),
                                                                      size: 15,
                                                                      weight: FontWeight
                                                                          .normal),
                                                                ),
                                                                SizedBox(
                                                                    height: 3),
                                                                Text(
                                                                  model
                                                                          .shortListModel
                                                                          .data![
                                                                              index]
                                                                          .bedroom
                                                                          .toString() +
                                                                      " bhk \u2022 " +
                                                                      model
                                                                          .shortListModel
                                                                          .data![
                                                                              index]
                                                                          .area
                                                                          .toString() +
                                                                      " sq.ft.",
                                                                  style: AppTextStyle(
                                                                      textColor: ColorRes
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8),
                                                                      size: 14,
                                                                      weight: FontWeight
                                                                          .normal),
                                                                ),
                                                                SizedBox(
                                                                    height: 3),
                                                                Text(
                                                                  /*     model
                                                                          .shortListModel
                                                                          .data![
                                                                              index]
                                                                          .category
                                                                          .toString() +
                                                                      ", " +*/
                                                                  model
                                                                      .shortListModel
                                                                      .data![
                                                                          index]
                                                                      .subCity
                                                                      .toString(),
                                                                  style: AppTextStyle(
                                                                      textColor: ColorRes
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8),
                                                                      size: 14,
                                                                      weight: FontWeight
                                                                          .normal),
                                                                ),
                                                                SizedBox(
                                                                    height: 3),
                                                              ],
                                                            ),
                                                            SizedBox(width: 10),
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                model.shortListModel.data![index]
                                                                            .dtmSchedule !=
                                                                        null
                                                                    ? SizedBox()
                                                                    : Container(
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/icons/save.png",
                                                                            color:
                                                                                ColorRes.white,
                                                                          ),
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            45,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                          color:
                                                                              ColorRes.raioContainer,
                                                                        ),
                                                                        alignment:
                                                                            Alignment.center,
                                                                      )
                                                              ],
                                                            ),
                                                            // SizedBox(width: 0),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      // model.tapping == model.infoList[index]["title"] ? Container(
                                                      model
                                                                  .shortListModel
                                                                  .data![index]
                                                                  .tourType ==
                                                              'physicaltour'
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorRes
                                                                    .raioContainer,
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15)),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            7),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/icons/men.png",
                                                                            color:
                                                                                ColorRes.shortlist,
                                                                          ),
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                10),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Center(
                                                                                child: Text(
                                                                              "Visit scheduled",
                                                                              style: AppTextStyle(textColor: ColorRes.shortlist, size: 14, weight: FontWeight.w700),
                                                                            )),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Center(
                                                                                child: Text(
                                                                              DateFormat('dd-MM-yyyy hh:mm a').format(model.shortListModel.data![index].dtmSchedule!)
                                                                              /*   "${model.shortListModel.data![index].dtmSchedule!.day}" +
                                                                                  " - " +
                                                                                  "${model.shortListModel.data![index].dtmSchedule!.month}" +
                                                                                  " - " +
                                                                                  "${model.shortListModel.data![index].dtmSchedule!.year}" +
                                                                                  " ${model.shortListModel.data![index].dtmSchedule!.hour} " +
                                                                                  ": ${model.shortListModel.data![index].dtmSchedule!.minute}"*/
                                                                              ,
                                                                              style: AppTextStyle(textColor: ColorRes.shortlist, size: 14, weight: FontWeight.w700),
                                                                            )),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              child: Text(
                                                                                "View",
                                                                                style: AppTextStyle(textColor: ColorRes.shortlist, size: 14, weight: FontWeight.w700),
                                                                              ),
                                                                              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20), border: Border.all(color: ColorRes.shortlist)),
                                                                              width: Get.width / 4,
                                                                              height: 40,
                                                                              alignment: Alignment.center,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                      )
                    ],
                  ),
          );
        });
  }
}
