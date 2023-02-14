import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/vrUrlViewScreen.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget startVidioExploreScreen(
    {required Function(String str)? mintap,
    void Function()? playVidioOnForyouTap,
    void Function()? playVidioexploreOnTap,
    void Function(bool play)? playvidioPausePlayOnTap,
    void Function()? onInformationTap,
    void Function()? chatView,
    required void Function()? onShareTap,
    bool? isClicked,
    List<bool>? isVidioShow,
    bool? isPlayHide,
    bool? isPauseHide,
    String? vidioUrl,
    String? selectedTab,
    required YoutubePlayerController controller,
    bool? isPlayerReady,
    bool? isPlay,
    bool? muted,
    PostExploreVideoModel? exploreModel,
    required int index,
    void Function()? stopSoundOnOff,
    required BuildContext context,
    required VoidCallback onShortListBtnTap,
    required bool showPlaceHolder,
    required Widget shortListBtn,
    required VoidCallback exploreTab,
    required bool isLoad}) {
  ScrollController scrollController = ScrollController(initialScrollOffset: 40);
  if (controller.value.isReady == false) controller.reset();
  return exploreModel!.data!.arrMatches == null ||
          exploreModel.data!.arrMatches == '' ||
          exploreModel.data!.arrMatches == []
      ? Text("no data here")
      : Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              color: Colors.transparent,
              child: YoutubePlayer(
                controller: controller,
                aspectRatio: 0.56,
              ),
            ),
           showPlaceHolder == true
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox(height: 0, width: 0),
            Positioned(
              child: Container(
                color: Colors.transparent,
                width: Get.width / 2.5,
                height: Get.height,
              ),
            ),
            Positioned(
              right: 10,
              child: Container(
                color: Colors.transparent,
                width: Get.width / 2.5,
                height: Get.height,
              ),
            ),
            Positioned(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  //need for start and stop video
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: Get.height / 5.5),
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height / 100),
                          SizedBox(height: Get.height / 100),
                        ],
                      ),

                      // 1A2231 - color
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 27, right: 27),
                  //explore bottom shadow
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // border: Border.all(width: 2,color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.65),
                        offset: const Offset(10.0, 10.0),
                        blurRadius: 35.0,
                        spreadRadius: 35.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: Get.height/10),
                              /*   Text(
                                    "100% Match",
                                    style: AppTextStyle(
                                        textColor: Colors.green,
                                        size: 16,
                                        weight: FontWeight.bold),
                                  ),*/
                              SizedBox(height: 5),
                              Text(
                                exploreModel.data!.arrMatches![index].title!
                                    .toString(),
                                style: AppTextStyle(
                                    textColor: Colors.white,
                                    size: 16,
                                    weight: FontWeight.w700),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "${exploreModel.data!.arrMatches![index].bedroom.toString()}" +
                                        " bhk \u2022",
                                    style: AppTextStyle(
                                      textColor: Colors.white.withOpacity(0.8),
                                      size: 15,
                                      weight: FontWeight.normal,
                                    ),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 3, left: 3),
                                  //   height: 5,
                                  //   width: 5,
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(5),
                                  //       color: ColorRes.white),
                                  // ),
                                  Text(
                                    " ${exploreModel.data!.arrMatches![index].area.toString()}" +
                                        " sq. ft. \u2022 ",
                                    style: AppTextStyle(
                                      textColor: Colors.white.withOpacity(0.8),
                                      size: 15,
                                      weight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    mintap!(exploreModel
                                        .data!.arrMatches![index].minPrice
                                        .toString()),
                                    style: AppTextStyle(
                                        textColor: Colors.white,
                                        size: 13,
                                        weight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${exploreModel.data!.arrMatches![index].subCity.toString()}" /*+
                                        "  ${exploreModel.data!.arrMatches![index].city.toString()}"*/
                                ,
                                style: AppTextStyle(
                                    textColor: Colors.white,
                                    size: 13,
                                    weight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
                shortListBtn,
                SizedBox(height: 15),
              ],
            )),
            Positioned(
              //explore icon column
              right: 27,
              bottom: Get.height * 0.073,
              child: Column(
                children: [
                  exploreModel.data!.arrMatches![index].vrLink!.isNotEmpty &&
                          exploreModel.data!.arrMatches![index].vrLink![0] != ""
                      ? GestureDetector(
                          onTap: () {
                            FirebaseAnalyticsService.sendAnalyticsEvent3(
                                Str.cFeeds,
                                Str.click,
                                Str.l360_view,
                                exploreModel.data!.arrMatches![index].id);
                            print("LINK OFN 360 VIEW  : : : " +
                                exploreModel.data!.arrMatches![index].vrLink![0]
                                    .toString());
                            //TODO:open in in web view
                            Get.to(() => VrUrlViewScreen(
                                  passUrl: exploreModel
                                      .data!.arrMatches![index].vrLink![0]
                                      .toString(),
                                  propertyId:
                                      exploreModel.data!.arrMatches![index].id,
                                ));
                          },
                          child: Container(
                            child: Image.asset("assets/icons/360icon.png",
                                color: Colors.white),
                            width: 28,
                            height: 28,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: stopSoundOnOff,
                    child: muted == true
                        ? Container(
                            child: Image.asset(
                              "assets/icons/soundOff.png",
                              color: Colors.white,
                            ),
                            width: 28,
                            height: 28,
                          )
                        : Container(
                            child: Image.asset("assets/icons/soundOn.png",
                                color: Colors.white),
                            width: 28,
                            height: 28,
                          ),

                    // child: Container(
                    //   child: Image.asset(
                    //       "assets/icons/soundOff.png", color: Colors.white),
                    //   width: 50,
                    //   height: 40,
                    // ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: chatView,
                    child: Container(
                      child: Image.asset("assets/icons/pencil.png",
                          color: Colors.white),
                      width: 28,
                      height: 28,
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: onInformationTap,
                    child: Container(
                      child: Image.asset("assets/icons/share.png",
                          color: Colors.white),
                      width: 28,
                      height: 28,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            showPlaceHolder == false
            ?Positioned(
              //explore play container
              top: 180,
              child: InkWell(
                onTap:exploreTab,
                child: Container(
                  width: Get.width - 60,
                  height: 220,
                  // decoration: BoxDecoration(
                  //     border: Border.all(width: 2)
                  // ),
                ),
              ),
            )
            :Container(),

            Positioned(
              top: 0,
              child: Container(
                height: Get.height / 2.45,
                width: Get.width,
                color: Colors.transparent,
              ),
            ),
            // showPlaceHolder == false
            //     ? Positioned(
            //         top: 300,
            //         right: 0,
            //         left: 0,
            //         child: AnimatedOpacity(
            //           opacity: 1.0,
            //           duration: Duration(milliseconds: 300),
            //           child: InkWell(
            //             onTap: exploreTab,
            //             child: Icon(
            //               isLoad == true ? Icons.pause : Icons.play_arrow,
            //               size: 30,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ),
            //       )
            //     : Container(),
          ],
        );
}
