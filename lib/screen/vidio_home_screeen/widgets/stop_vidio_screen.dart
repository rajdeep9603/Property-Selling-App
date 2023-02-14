import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/screen/property_details/property_details_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/vidio_view_model.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget stopVidioScreen({
  YoutubePlayerController? controller,
  void Function()? onForyouTap,
  void Function()? exploreOnTap,
  void Function(bool play)? stopPausePlayOnTap,
  void Function()? onShortlistTap,
  bool? isClicked,
  List<bool>? isVidioShow,
  bool? isPlayHide,
  bool? isPauseHide,
  String? vidioUrl,
  String? selectedTab,
  bool? isPlayerReady,
  bool? isPlay,
  bool? muted,
  required VoidCallback stopSoundOnOff,
  required VoidCallback onShareTap,
  required VoidCallback onInformationTap,
  bool? isPlaying,
  PostPreferenceModel? feedModel,
  PageController? pageController,
  required int index,
  required BuildContext context,
  bool? showImage,
  String? image,
}) {
  bool cont = false;
/*  controller!.listen((event) {
    cont = event.isReady;
  });
  if (cont == false) Image.asset("assets/image/bg.jpg");*/
  return feedModel!.data!.arrMatches == null || feedModel.data!.arrMatches == []
      ? Container(
          alignment: Alignment.center,
          width: Get.width,
          height: Get.height,
          child: Text(
            "No vidioes found \n\n please select another preference",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorRes.white,
              fontSize: 20,
            ),
          ),
          color: ColorRes.black,
        )
      : Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height - 20,
              child: showImage == true
                  ? Image.network(
                      image!,
                      fit: BoxFit.cover,
                    )
                  : YoutubePlayer(
                      controller: controller!,
                      aspectRatio: 0.65,
                    ),
              //child: player,
            ),
            Positioned(
                child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black.withOpacity(0.7),
            )),
            feedModel.data!.arrMatches == null ||
                    feedModel.data!.arrMatches == []
                ? Positioned(
                    right: 0,
                    left: 0,
                    top: 0,
                    child: Container(
                      //width: Get.width,
                      height: Get.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height / 10,
                          ),
                          SizedBox(
                            height: Get.height / 3.4,
                          ),


                         /* Center(
                              child: AnimatedOpacity(
                                // opacity:isClicked == true ? 0.0 : 1.0,
                                opacity: isClicked == true ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: YoutubeValueBuilder(
                                  controller: controller,
                                  builder: (context, value) {
                                    return InkWell(
                                      onTap: () {
                                        print("PLAY PAUSE EVENT");
                                        stopPausePlayOnTap!(
                                            value.playerState == PlayerState.playing && !value.hasPlayed);
                                        stopPausePlayOnTap!(false);
                                      },
                                      child:
                                      value.playerState == PlayerState.playing
                                          ? Container(
                                        width: Get.width,
                                        height: 80,
                                        child: Icon(
                                          Icons.pause,
                                          size: 55,
                                          color: ColorRes.white,
                                        ),
                                      )
                                          : Container(
                                        width: Get.width,
                                        height: 60,
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          size: 55,
                                          color: ColorRes.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),*/
                          // SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Get.height / 10),
                                      /*      Text(
                              "100% Match",
                              style: AppTextStyle(
                                  textColor:
                                  Colors.green.withOpacity(0.9),
                                  size: 15,
                                  weight: FontWeight.w700),
                            ),*/
                                      SizedBox(height: 5),
                                      Text(
                                        feedModel
                                            .data!.arrMatches![index].title!
                                            .toString(),
                                        style: AppTextStyle(
                                            textColor: Colors.white,
                                            size: 18,
                                            weight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${feedModel.data!.arrMatches![index].bedroom.toString()}" +
                                            " bhk," +
                                            " ${feedModel.data!.arrMatches![index].area.toString()}" +
                                            "sq. ft.",
                                        style: AppTextStyle(
                                          textColor: Colors.white,
                                          size: 15,
                                          weight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${feedModel.data!.arrMatches![index].subCity.toString()}" +
                                            "  ${feedModel.data!.arrMatches![index].city.toString()}",
                                        style: AppTextStyle(
                                            textColor:
                                                Colors.white.withOpacity(0.8),
                                            size: 15,
                                            weight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),

                                //for sound on off
                                // Column(
                                //   children: [
                                //     GestureDetector(
                                //         /*onTap: model.isPlayerReady ? () {
                                //           model.muted = !model.muted;
                                //           model.muted == false
                                //               ? model.controller[index].unMute()
                                //               : model.controller[index].mute();
                                //           model.notifyListeners();
                                //         } : () {
                                //           model.isPlayerReady = false;
                                //           model.notifyListeners();
                                //         },*/
                                //       onTap:stopSoundOnOff,
                                //         child: muted == true ? Container(
                                //           child: Image.asset("assets/icons/soundOff.png",
                                //             color: Colors.white,),
                                //           width: 50,
                                //           height: 40,
                                //         ) : Container(
                                //           child: Icon(Icons.volume_up, size: 35,
                                //             color: Colors.white,),
                                //           width: 50,
                                //           height: 40,
                                //         )
                                //     ),
                                //     // Icon(Icons.surround_sound_rounded,size: 30,color: Colors.white,),
                                //     SizedBox(height: 25),
                                //     Container(
                                //       child: Image.asset(
                                //           "assets/icons/share.png", color: Colors.white),
                                //       width: 50,
                                //       height: 40,
                                //     ),
                                //   ],
                                // ),

                                Column(
                                  children: [
                                    // GestureDetector(
                                    //   child: Container(
                                    //     child: Image.asset(
                                    //         "assets/icons/soundOff.png", color: Colors.white),
                                    //     width: 50,
                                    //     height: 40,
                                    //   ),
                                    //   onTap:stopSoundOnOff,
                                    // ),

                                    GestureDetector(
                                      onTap: stopSoundOnOff,
                                      child: muted == true
                                          ? Container(
                                              child: Image.asset(
                                                "assets/icons/soundOff.png",
                                                color: Colors.white,
                                              ),
                                              width: 50,
                                              height: 40,
                                            )
                                          : Container(
                                              child: Icon(
                                                Icons.volume_up,
                                                size: 35,
                                                color: Colors.white,
                                              ),
                                              width: 50,
                                              height: 40,
                                            ),

                                      // child: Container(
                                      //   child: Image.asset(
                                      //       "assets/icons/soundOff.png", color: Colors.white),
                                      //   width: 50,
                                      //   height: 40,
                                      // ),
                                    ),

                                    SizedBox(height: Get.height / 50),
                                    GestureDetector(
                                      onTap: onShareTap,
                                      child: Container(
                                        child: Image.asset(
                                            "assets/icons/newShareIcon.png",
                                            color: Colors.white),
                                        width: 30,
                                        height: 22,
                                      ),
                                    ),
                                    SizedBox(height: Get.height / 40),
                                    Container(
                                      child: Image.asset(
                                          "assets/icons/pencil.png",
                                          color: Colors.white),
                                      width: 50,
                                      height: 40,
                                    ),
                                    SizedBox(height: Get.height / 60),
                                    GestureDetector(
                                      onTap: onInformationTap,
                                      child: Container(
                                        child: Image.asset(
                                            "assets/icons/share.png",
                                            color: Colors.white),
                                        width: 50,
                                        height: 40,
                                      ),
                                    ),
                                    SizedBox(height: Get.height / 50),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height:Get.height/50),
                          // SizedBox(height: Get.height / 50,),
                          // SizedBox(height:Get.height/60),
                          SizedBox(height: Get.height / 200),
                          InkWell(
                            onTap: onShortlistTap,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 17),
                              alignment: Alignment.center,
                              width: Get.width,
                              height: Get.height / 15,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: ColorRes.btnBg),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 18,
                                    child: Image.asset(
                                      "assets/icons/save.png",
                                      color: ColorRes.btnBg,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    AppRes.shortlist,
                                    style: AppTextStyle(
                                        textColor: ColorRes.btnBg,
                                        size: 16,
                                        weight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: Get.height / 100),

                          // SizedBox(height: Get.height/70,),
                        ],
                      ),
                    ))
                : SizedBox(
                    width: 200,
                    height: 200,
                    child: Text("No data found"),
                  ),
          ],
        );
}
