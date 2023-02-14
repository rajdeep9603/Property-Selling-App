import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/vrUrlViewScreen.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget startVidioScreen(
    {required Function(String str)? mintap,
    void Function()? playVidioOnForyouTap,
    void Function()? playVidioexploreOnTap,
    void Function(bool play)? playvidioPausePlayOnTap,
    void Function()? onInformationTap,
    void Function()? chatview,
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
    PostPreferenceModel? feedModel,
    required int index,
    void Function()? stopSoundOnOff,
    required BuildContext context,
    required VoidCallback onShortlistBtnTap,
    required bool showPlaceHolder,
    required Widget shortListBtn,
    required VoidCallback forYouTab,
    required bool isLoad}) {
  ScrollController scrollController = ScrollController(initialScrollOffset: 40);
  if (controller.value.isReady == false) controller.reset();
  return Container(
    width: Get.width,
    height: Get.height,
    child: Stack(
      children: [
        feedModel!.data!.arrMatches == null ||
                feedModel.data!.arrMatches == '' ||
                feedModel.data!.arrMatches == []
            ? Container(
                alignment: Alignment.center,
                width: Get.width,
                height: Get.height,
                child: Center(
                  child: Text(
                    "No vidioes found \n\n please select another preference",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorRes.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                color: ColorRes.black,
              )
            : Container(
                width: Get.width,
                height: Get.height,
                // child:Image.asset("assets/image/vidioBg.png",fit: BoxFit.cover,),
                child: YoutubePlayer(
                  controller: controller,
                  aspectRatio: 0.56,
                ), /*SingleChildScrollView(
                  controller: scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  child: YoutubePlayerIFrame(
                    controller: controller,
                    aspectRatio: 0.56,
                  ),
                )*/
              ),
     showPlaceHolder == true
            ? Container(
                width: Get.width,
                height: Get.height,
                color: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
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
        Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Get.height / 2.2,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Container(
                  //for you bottom shadow
                  padding: EdgeInsets.only(left: 20, right: 27),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // border: Border.all(color: Colors.white),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: Get.height/10),
                                /*  Text(
                                        "100% Match",
                                        style: AppTextStyle(
                                            textColor:
                                                Colors.green.withOpacity(0.8),
                                            size: 15,
                                            weight: FontWeight.bold),
                                      ),*/
                                SizedBox(height: Get.height / 120),
                                Text(
                                  feedModel.data!.arrMatches![index].title!
                                      .toString(),
                                  style: AppTextStyle(
                                      textColor: Colors.white,
                                      size: 17,
                                      weight: FontWeight.w700),
                                ),
                                SizedBox(height: Get.height / 120),

                                Row(
                                  children: [
                                    Text(
                                      "${feedModel.data!.arrMatches![index].bedroom.toString()}" +
                                          " bhk",
                                      style: AppTextStyle(
                                        textColor:
                                            Colors.white.withOpacity(0.8),
                                        size: 15,
                                        weight: FontWeight.normal,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 3, left: 3),
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ColorRes.white),
                                    ),
                                    Text(
                                      " ${feedModel.data!.arrMatches![index].area.toString()}" +
                                          " sq. ft. \u2022 ",
                                      style: AppTextStyle(
                                        textColor:
                                            Colors.white.withOpacity(0.8),
                                        size: 15,
                                        weight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      mintap!(feedModel
                                          .data!.arrMatches![index].minPrice
                                          .toString()),
                                      style: AppTextStyle(
                                          textColor: Colors.white,
                                          size: 13,
                                          weight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height / 120),
                                Text(
                                  "${feedModel.data!.arrMatches![index].subCity.toString()}" /*+
                                            "  ${feedModel.data!.arrMatches![index].city.toString()}"*/
                                  ,
                                  style: AppTextStyle(
                                      textColor: Colors.white.withOpacity(0.8),
                                      size: 15,
                                      weight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
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
          //for you icon column
          right: 27,
          bottom: Get.height * 0.073,
          child: Column(
            children: [
              feedModel.data!.arrMatches![index].vrLink!.isNotEmpty &&
                      feedModel.data!.arrMatches![index].vrLink![0] != ""
                  ? GestureDetector(
                      onTap: () {
                        FirebaseAnalyticsService.sendAnalyticsEvent3(
                            Str.cFeeds,
                            Str.click,
                            Str.l360_view,
                            feedModel.data!.arrMatches![index].id);
                        //TODO:open in in web view
                        Get.to(() => VrUrlViewScreen(
                              passUrl: feedModel
                                  .data!.arrMatches![index].vrLink![0]
                                  .toString(),
                              propertyId: feedModel.data!.arrMatches![index].id,
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
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  stopSoundOnOff!();
                },
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
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: chatview,
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
        showPlaceHolder ==false?
        Positioned(
          //for you play container
          top: 180,
          child: InkWell(
            onTap:forYouTab,
            child: Container(
              width: Get.width - 60,
              height: 220,
              // decoration: BoxDecoration(
              //   border: Border.all(width: 2)
              // ),
            ),
          ),
        ):Container(),

        Positioned(
          top: 0,
          child: Container(
            height: Get.height / 2.45,
            width: Get.width,
            color: Colors.transparent,
          ),
        ),
        // showPlaceHolder ==false?
        // Positioned(
        //   top: 300,
        //   right: 0,
        //   left: 0,
        //   child: AnimatedOpacity(
        //     opacity: 1.0,
        //     duration: Duration(milliseconds: 300),
        //     child: InkWell(
        //       onTap: forYouTab,
        //       child: Icon(
        //         isLoad == true
        //             ? Icons.pause
        //             : Icons.play_arrow,
        //         size: 30,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        // ):Container(),
      ],
    ),
  );
}
