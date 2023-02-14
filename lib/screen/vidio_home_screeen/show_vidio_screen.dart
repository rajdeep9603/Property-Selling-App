import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/vidio_view_model.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/bottem_bar.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/bottom_schedule_buttons.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/select_other_preferences.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/start_vidio_explore_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/start_vidio_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/stop_vidio_explore_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/stop_vidio_screen.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_loader_new.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:snapping_page_scroll/snapping_page_scroll.dart';
import 'package:stacked/stacked.dart';

import 'vidio_view_model.dart';

class VidioScreen extends StatefulWidget {
  PostPreferenceModel? feedModel;

  VidioScreen({this.feedModel});

  @override
  _VidioScreenState createState() => _VidioScreenState();
}

class _VidioScreenState extends State<VidioScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreVidioViewModel>.reactive(
        onModelReady: (model) {
          if (widget.feedModel != null &&
              widget.feedModel!.status.toString() == "true") {
            model.init(widget.feedModel);
          } else {
            // Fluttertoast.showToast(
            //     msg: "Data not Found",
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.blue,
            //     textColor: Colors.white,
            //     fontSize: 18);
          }
        },
        viewModelBuilder: () => ExploreVidioViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            //bottom navigation video

            bottomNavigationBar: model.showBottomNavigationBar
                ? bottemBarStopVidio(
                    onHomeTap: model.onHomeTap,
                    onSettingTap: model.onSettingTap,
                    onShortListTap: () => model.onShortListTap(context),
                    indexBottem: model.indexBottem,
                  )
                : Container(
                    height: 0,
                  ),
            body: model.showShortList
                ? ShortListScreen()
                : model.settingTapOfNavigation
                    ? InterSelectionScreen()
                    : GestureDetector(
                        onHorizontalDragUpdate: (detail) {
                          print("aaaaa");
                          print(detail.delta.dx);
                          if (detail.delta.dx.obs > 8) {
                            print("prev");
                            model.selectedTab = AppRes.explore;
                            model.exploreOnTap();
                          } else if (detail.delta.dx.obs < -8) {
                            print("next");
                            model.selectedTab = AppRes.foryou;
                            model.onForyouTap();
                          }
                        },
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: Stack(
                            children: [
                              /*feedModel.status == false
                        ? Center(
                            child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.black,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Data Not Found",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : */
                              model.selectedTab == AppRes.foryou
                                  ? Stack(
                                      children: [
                                        widget.feedModel == null ||
                                                widget.feedModel!.data ==
                                                    null ||
                                                widget.feedModel!.data!
                                                        .arrMatches ==
                                                    null ||
                                                widget.feedModel!.data!
                                                        .arrMatches ==
                                                    [] ||
                                                widget.feedModel!.data!
                                                    .arrMatches!.isEmpty
                                            ? selectOtherPref()
                                            : PageView.builder(
                                                scrollDirection: Axis.vertical,
                                                physics:ClampingScrollPhysics() ,
                                                // physics: model.scroll ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
                                                onPageChanged: model.onChanged,
                                                controller:
                                                    model.pageController,
                                                itemCount: model
                                                        .controller.isEmpty
                                                    ? model.imgUrl.length
                                                    : model.controller.length,
                                                itemBuilder:
                                                    (context, int index) {
                                                  if(index == 0){
                                                    print("INDEX SCROLL on  0 : $index ");
                                                    model.scroll= false;
                                                    model.notifyListeners();
                                                  }else {
                                                    print("INDEX SCROLL other : $index ");
                                                    model.scroll = true;
                                                    model.notifyListeners();
                                                  }
                                                  return index <
                                                          model
                                                              .controller.length
                                                      ? startVidioScreen(
                                                          mintap:
                                                              model.minPrice,
                                                          shortListBtn:
                                                              BottomScheduleButtons(
                                                            PID: feedModel
                                                                .data!
                                                                .arrMatches![
                                                                    index]
                                                                .id!,
                                                            onShortListBtnTap:
                                                                () => model
                                                                    .onShortListBtnTap(
                                                                        index),
                                                            arrMatch: feedModel
                                                                    .data!
                                                                    .arrMatches![
                                                                index],
                                                            onDateSelect: () =>
                                                                model.onDateSelect(
                                                                    index,
                                                                    feedModel
                                                                        .data!
                                                                        .arrMatches![
                                                                            index]
                                                                        .id),
                                                            onDateUpdate: () =>
                                                                model
                                                                    .onDateUpdate(
                                                                        index),
                                                          ),
                                                          /* showPlaceHolder: false,*/
                                                          showPlaceHolder:
                                                              model.showPlaceHolder[
                                                                  index],
                                                          context: context,
                                                          playVidioexploreOnTap: model
                                                              .playVidioexploreOnTap,
                                                          playVidioOnForyouTap: model
                                                              .playVidioOnForyouTap,
                                                          playvidioPausePlayOnTap: model
                                                              .playvidioPausePlayOnTap,
                                                          controller:
                                                              model.controller[
                                                                  index],
                                                          isClicked:
                                                              model.isClicked,
                                                          isPauseHide:
                                                              model.isPlayHide,
                                                          isPlay: model.isPlay,
                                                          isPlayerReady: model
                                                              .isPlayerReady,
                                                          isPlayHide:
                                                              model.isPlayHide,
                                                          muted: model.muted,
                                                          // playerState:model.playerState,
                                                          selectedTab:
                                                              model.selectedTab,
                                                          // videoMetaData: model.videoMetaData,
                                                          vidioUrl:
                                                              model.vidioUrl,
                                                          feedModel: feedModel,
                                                          index: index,
                                                          onShortlistBtnTap: () =>
                                                              model.onShortListBtnTap(
                                                                  index),
                                                          stopSoundOnOff: model
                                                              .stopSoundOnOff,
                                                          onInformationTap: () =>
                                                              model.onInformationTap(
                                                                  index),
                                                          chatview: () => model
                                                              .chatview(index),
                                                          onShareTap:
                                                              model.onShareTap,
                                                          forYouTab: () => model.forYouController(index),
                                                          isLoad: isForuLoad.length == 0 ? isForuLoad[0] : isForuLoad[index])
                                                      : stopVidioScreen(
                                                          // onShareTap: model.onShareTap(context),
                                                          onShareTap:
                                                              model.onShareTap,
                                                          //player: player,
                                                          onForyouTap:
                                                              model.onForyouTap,
                                                          exploreOnTap: model
                                                              .exploreOnTap,
                                                          onShortlistTap: () =>
                                                              model
                                                                  .onShortListBtnTap(
                                                                      index),
                                                          //stopPausePlayOnTap: model.stoppausePlayOnTap,
                                                          // controller: model.controller,
                                                          image: model
                                                              .imgUrl[index],
                                                          showImage: true,
                                                          isClicked:
                                                              model.isClicked,
                                                          //isPauseHide: model.isPlayHide,
                                                          isPlay: model.isPlay,
                                                          isPlayerReady: model
                                                              .isPlayerReady,
                                                          isPlayHide:
                                                              model.isPlayHide,
                                                          isVidioShow:
                                                              model.isVidioShow,
                                                          muted: model.muted,
                                                          // playerState:model.playerState,
                                                          selectedTab:
                                                              model.selectedTab,
                                                          // videoMetaData: model.videoMetaData,
                                                          vidioUrl:
                                                              model.vidioUrl,
                                                          stopSoundOnOff: model
                                                              .stopSoundOnOff,
                                                          // isPlaying: model.controller[index].value.isPlaying,
                                                          feedModel: feedModel,
                                                          pageController: model
                                                              .pageController,
                                                          onInformationTap:
                                                              () => model
                                                                  .onInformationTap(
                                                                      index),
                                                          context: context,
                                                          index: index,
                                                        );
                                                },
                                              ),

                                        //FOR VIDIO STACK TABBAR

                                        Positioned(
                                          //for you shadow
                                          // bottom: 0,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 15),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //     color: Colors.white
                                                    // ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.65),
                                                        offset:
                                                            Offset(10.0, 10.0),
                                                        blurRadius: 35.0,
                                                        spreadRadius: 25.0,
                                                      ), //BoxShadow
                                                    ],
                                                  ),
                                                  child: Row(
                                                    //for you title row
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 90,
                                                      ),
                                                      GestureDetector(
                                                        onTap:
                                                            model.onForyouTap,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: Get.width / 5,
                                                          height: 30,
                                                          child: Text(
                                                            AppRes.foryou,
                                                            style: AppTextStyle(
                                                                textColor:
                                                                    ColorRes
                                                                        .white,
                                                                size: 16),
                                                          ),
                                                          decoration: model
                                                                      .selectedTab ==
                                                                  AppRes.foryou
                                                              ? BoxDecoration(
                                                                  color: ColorRes
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: ColorRes
                                                                          .white),
                                                                )
                                                              : BoxDecoration(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      GestureDetector(
                                                        onTap:
                                                            model.exploreOnTap,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: Get.width / 5,
                                                          height: 30,
                                                          decoration: model
                                                                      .selectedTab ==
                                                                  AppRes.explore
                                                              ? BoxDecoration(
                                                                  color: ColorRes
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: ColorRes
                                                                          .white),
                                                                )
                                                              : BoxDecoration(),
                                                          child: Text(
                                                            AppRes.explore,
                                                            style: AppTextStyle(
                                                                textColor:
                                                                    ColorRes
                                                                        .white,
                                                                size: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap:
                                                            model.onChatBtnTap,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          width: 50,
                                                          height: 50,
                                                          // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                                                          child: Image.asset(
                                                              "assets/icons/chat.png",
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 27,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //for you chat container
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: GestureDetector(
                                            onTap: model.onChatBtnTap,
                                            child: Container(
                                              height: 80,
                                              width: 100,
                                              // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                                              alignment: Alignment.center,
                                              // child: GestureDetector(
                                              //   onTap:  model.onChatBtnTap,
                                              //   child: Container(
                                              //     height: 60,
                                              //     width: 100,
                                              //     decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(
                                      width: Get.width,
                                      height: Get.height,
                                      child: model.isBusy
                                          ? commonLoader()
                                          : Stack(
                                              children: [
                                                model.exploreModel
                                                                .data ==
                                                            null ||
                                                        model.exploreModel.data!
                                                                .arrMatches ==
                                                            null ||
                                                        model.exploreModel.data!
                                                                .arrMatches ==
                                                            [] ||
                                                        model.exploreModel.data!
                                                            .arrMatches!.isEmpty
                                                    ? selectOtherPref()
                                                    : Stack(
                                                        children: [
                                                          PageView.builder(
                                                            physics:ClampingScrollPhysics() ,
                                                            pageSnapping: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            onPageChanged: model
                                                                .onChangedExlore,
                                                            controller: model
                                                                .explorePageController,
                                                            // itemCount: model.feedModel.result!.arrMatches!.length,
                                                            itemCount: model
                                                                    .controllerExplore
                                                                    .isEmpty
                                                                ? model
                                                                    .exploreImgUrl
                                                                    .length
                                                                : model
                                                                    .controllerExplore
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    int index) {
                                                              return index <
                                                                      model
                                                                          .controllerExplore
                                                                          .length
                                                                  ? startVidioExploreScreen(
                                                                      mintap: model
                                                                          .minPrice,
                                                                      shortListBtn:
                                                                          BottomScheduleButtons(
                                                                        PID: model
                                                                            .exploreModel
                                                                            .data!
                                                                            .arrMatches![index]
                                                                            .id!,
                                                                        onShortListBtnTap:
                                                                            () =>
                                                                                model.onShortListBtnTap(index),
                                                                        arrMatch: model
                                                                            .exploreModel
                                                                            .data!
                                                                            .arrMatches![index],
                                                                        onDateSelect: () => model.onDateSelect(
                                                                            index,
                                                                            model.exploreModel.data!.arrMatches![index].id),
                                                                        onDateUpdate:
                                                                            () =>
                                                                                model.onDateUpdate(index),
                                                                      ),
                                                                      context:
                                                                          context,
                                                                      /*showPlaceHolder:
                                                                true,*/
                                                                      showPlaceHolder:
                                                                          model.showPlaceHolder[model
                                                                              .pageIndex],
                                                                      onShortListBtnTap: () =>
                                                                          model.onShortListBtnTap(
                                                                              index),
                                                                      playVidioexploreOnTap: model
                                                                          .playVidioexploreOnTap,
                                                                      playVidioOnForyouTap: model
                                                                          .playVidioOnForyouTap,
                                                                      playvidioPausePlayOnTap: model
                                                                          .playvidioPausePlayOnTap,
                                                                      controller:
                                                                          model.controllerExplore[
                                                                              index],
                                                                      isClicked: model
                                                                          .isClicked,
                                                                      isPauseHide: model
                                                                          .isPlayHide,
                                                                      isPlay: model
                                                                          .isPlay,
                                                                      isPlayerReady: model
                                                                          .isPlayerReady,
                                                                      isPlayHide: model
                                                                          .isPlayHide,
                                                                      isVidioShow:
                                                                          model
                                                                              .isVidioShow,
                                                                      muted: model
                                                                          .muted,
                                                                      // playerState:model.playerStateExplore,
                                                                      selectedTab:
                                                                          model.selectedTab,
                                                                      // videoMetaData: model.videoMetaDataExplore,
                                                                      vidioUrl: model.vidioUrl,
                                                                      index: index,
                                                                      stopSoundOnOff: model.playSoundOnOff,
                                                                      onInformationTap: () => model.onInformationTap(index),
                                                                      chatView: () => model.chatview(index),
                                                                      onShareTap: model.onShareTap,
                                                                      exploreModel: model.exploreModel,
                                                                      exploreTab: () => model.exploreController(index),
                                                                      isLoad: isExpLoad[index])
                                                                  : stopVidioExploreScreen(
                                                                      image: model
                                                                              .exploreImgUrl[
                                                                          index],

                                                                      onShareTap:
                                                                          model
                                                                              .onShareTap,
                                                                      //player: player,
                                                                      onForyouTap:
                                                                          model
                                                                              .onForyouTap,
                                                                      exploreOnTap:
                                                                          model
                                                                              .exploreOnTap,
                                                                      onShortlistTap:
                                                                          () =>
                                                                              model.onShortListBtnTap(index),
                                                                      stopPausePlayOnTap:
                                                                          model
                                                                              .stoppausePlayOnTap,
                                                                      controller:
                                                                          model.controllerExplore[
                                                                              index],
                                                                      isClicked:
                                                                          model
                                                                              .isClicked,
                                                                      isPauseHide:
                                                                          model
                                                                              .isPlayHide,
                                                                      isPlay: model
                                                                          .isPlay,
                                                                      isPlayerReady:
                                                                          model
                                                                              .isPlayerReady,
                                                                      isPlayHide:
                                                                          model
                                                                              .isPlayHide,
                                                                      isVidioShow:
                                                                          model
                                                                              .isVidioShow,
                                                                      muted: model
                                                                          .muted,
                                                                      // playerState:model.playerStateExplore,
                                                                      selectedTab:
                                                                          model
                                                                              .selectedTab,
                                                                      // videoMetaData: model.videoMetaDataExplore,
                                                                      vidioUrl:
                                                                          model
                                                                              .vidioUrl,
                                                                      stopSoundOnOff:
                                                                          model
                                                                              .playSoundOnOff,

                                                                      pageController:
                                                                          model
                                                                              .pageController,
                                                                      onInformationTap:
                                                                          () =>
                                                                              model.onInformationTap(index),
                                                                      context:
                                                                          context,
                                                                      index:
                                                                          index,
                                                                      exploreModel:
                                                                          model
                                                                              .exploreModel,
                                                                    );
                                                            },
                                                          ),
                                                          Positioned(
                                                              child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              //explore shadow
                                                              // color: Colors.black.withOpacity(0.4),
                                                              // border: Border.all(color: Colors.white),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.65),
                                                                  offset:
                                                                      const Offset(
                                                                          5.0,
                                                                          5.0),
                                                                  blurRadius:
                                                                      35.0,
                                                                  spreadRadius:
                                                                      25.0,
                                                                ), //BoxShadow
                                                              ],
                                                            ),
                                                            width: Get.width,
                                                            height:
                                                                Get.height / 10,
                                                          )),
                                                        ],
                                                      ),

                                                //for stack tabbar
                                                Positioned(
                                                    child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 15),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          //explore title row
                                                          SizedBox(
                                                            width: 90,
                                                          ),
                                                          GestureDetector(
                                                            onTap: model
                                                                .onForyouTap,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width:
                                                                  Get.width / 5,
                                                              height: 30,
                                                              child: Text(
                                                                AppRes.foryou,
                                                                style: AppTextStyle(
                                                                    textColor:
                                                                        ColorRes
                                                                            .white,
                                                                    size: 16),
                                                              ),
                                                              decoration: model
                                                                          .selectedTab ==
                                                                      AppRes
                                                                          .foryou
                                                                  ? BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color:
                                                                              ColorRes.white),
                                                                    )
                                                                  : BoxDecoration(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          GestureDetector(
                                                            onTap: model
                                                                .exploreOnTap,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width:
                                                                  Get.width / 5,
                                                              height: 30,
                                                              decoration: model
                                                                          .selectedTab ==
                                                                      AppRes
                                                                          .explore
                                                                  ? BoxDecoration(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color:
                                                                              ColorRes.white),
                                                                    )
                                                                  : BoxDecoration(),
                                                              child: Text(
                                                                AppRes.explore,
                                                                style: AppTextStyle(
                                                                    textColor:
                                                                        ColorRes
                                                                            .white,
                                                                    size: 16),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Spacer(),
                                                          InkWell(
                                                            onTap: model
                                                                .onChatBtnTap,
                                                            child: Container(
                                                              // decoration: BoxDecoration(border: Border.all(width: 2)),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              width: 50,
                                                              height: 50,
                                                              child: Image.asset(
                                                                  "assets/icons/chat.png",
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 27,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )),

                                                //explore chat container
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: GestureDetector(
                                                    onTap: model.onChatBtnTap,
                                                    child: Container(
                                                      height: 80,
                                                      width: 100,
                                                      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                                                      alignment:
                                                          Alignment.center,
                                                      // child: GestureDetector(
                                                      //   onTap:  model.onChatBtnTap,
                                                      //   child: Container(
                                                      //     height: 60,
                                                      //     width: 100,
                                                      //     decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                    ),
                              model.exploreLoader
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(),
                              /*model.shortListLoader
                        ? commonLoader()
                        : SizedBox(height: 0, width: 0),*/
                            ],
                          ),
                        ),
                      ),
          );
        });
  }
}
