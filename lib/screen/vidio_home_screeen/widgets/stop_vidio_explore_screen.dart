import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


Widget stopVidioExploreScreen({
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
  required YoutubePlayerController controller,
  bool? isPlayerReady,
  bool? isPlay,
  bool? muted,
  required VoidCallback stopSoundOnOff,
  required VoidCallback onShareTap,
  required VoidCallback onInformationTap,
  bool? isPlaying,
  PostExploreVideoModel? exploreModel,
  PageController? pageController,
  required int index,
  required BuildContext context,
  bool? showImage,
  String? image,
}) {
/*  bool cont=false;
  controller.listen((event) {
    cont=event.isReady;

  });
  if(cont==false)
    Image.asset("assets/image/bg.jpg");*/
  return exploreModel!.data!.arrMatches == null ||
          exploreModel.data!.arrMatches == []
      ? Text("no data here")
      : Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              color: Colors.transparent,
              /*child: showImage == true
            ? Image.network(
                image!,
                fit: BoxFit.cover,
              )
            : YoutubePlayerIFrame(
          controller: controller,
          aspectRatio: 16 / 9,
        ),*/
              // child: player,
            ),
            Positioned(
                child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black.withOpacity(0.7),
            )),

            // Positioned(child:Container(
            //   width: 200,
            //   height: 200,
            //   color: Colors.black,
            // )),

            Positioned(
                right: 0,
                left: 0,
                child: Container(
                  // width: Get.width,
                  height: Get.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: Get.height / 12),

                      //tabs
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Spacer(flex: 20,),
                      //       GestureDetector(
                      //         onTap:onForyouTap,
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           width: Get.width / 5,
                      //           height: 30,
                      //           child: Text(AppRes.foryou, style: AppTextStyle(
                      //               textColor: ColorRes.white, size: 16),),
                      //           decoration: selectedTab == AppRes.foryou
                      //               ? BoxDecoration(
                      //             color: Colors.grey.withOpacity(0.5),
                      //             borderRadius: BorderRadius.circular(20),
                      //             border: Border.all(color: ColorRes.white),
                      //           )
                      //               : BoxDecoration(),
                      //         ),
                      //       ),
                      //       SizedBox(width: 15,),
                      //       GestureDetector(
                      //         onTap: exploreOnTap,
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           width: Get.width / 5,
                      //           height: 30,
                      //           decoration:selectedTab == AppRes.explore
                      //               ? BoxDecoration(
                      //             color: Colors.grey.withOpacity(0.5),
                      //             borderRadius: BorderRadius.circular(20),
                      //             border: Border.all(color: ColorRes.white),
                      //           )
                      //               : BoxDecoration(),
                      //           child: Text(AppRes.explore, style: AppTextStyle(
                      //               textColor: ColorRes.white, size: 16),),
                      //         ),
                      //       ),
                      //       Spacer(),
                      //       Spacer(),
                      //       Spacer(),
                      //       Spacer(),
                      //       Spacer(),
                      //       Spacer(),
                      //       Spacer(),
                      //       Spacer(),
                      //       Container(
                      //         child: Image.asset(
                      //             "assets/icons/chat.png", color: Colors.white),
                      //         width: 50,
                      //         height: 45,
                      //       ),
                      //       Spacer(),
                      //     ],
                      //   ),
                      // ),

                      // AnimatedContainer(
                      //   duration: const Duration(milliseconds: 800),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20.0),
                      //     color: Colors.white,
                      //   ),
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     model.playerState.toString(),
                      //     style: const TextStyle(
                      //       fontWeight: FontWeight.w300,
                      //       color: Colors.white,
                      //     ),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      // SizedBox(height: Get.height / 3.4,),
                      // Center(child: Icon(Icons.play_circle_fill,size: 60,color: ColorRes.white,)),
                      Container(height: Get.height / 5),
                   /*   Container(
                        height: Get.height/5,
                        width: 20,
                        color: Colors.red,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              controller.value.isPlaying == true
                                  ? controller.pause()
                                  : controller.play();
                            },
                            child: Icon(
                              controller.value.isPlaying == false
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),*/
                      Center(
                          child: AnimatedOpacity(
                            // opacity:isClicked == true ? 0.0 : 1.0,
                            opacity: isClicked == true ? 1.0 : 1.0,
                            duration: Duration(milliseconds: 300),
                            child: Container(
                              height: 30,
                              width: 30,
                              color: Colors.red,
                              child: InkWell(
                                onTap: () {
                                  controller.value.isPlaying == true
                                      ? controller.pause()
                                      : controller.play();
                                },
                                child: Icon(
                                  controller.value.isPlaying == false
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )),
                      /*Center(
                          child: AnimatedOpacity(
                        // opacity:isClicked == true ? 0.0 : 1.0,
                        opacity: isClicked == true ? 1.0 : 1.0,
                        duration: Duration(milliseconds: 300),
                        child: YoutubeValueBuilder(
                          controller: controller,
                          builder: (context, value) {
                            return InkWell(
                              onTap: () {
                                print("PLAY PAUSE EVENT");
                                stopPausePlayOnTap!(
                                    value.playerState == PlayerState.playing);
                              },
                              child: value.playerState == PlayerState.playing
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height / 7),
                                /*  Text(
                            "100% Match",
                            style: AppTextStyle(
                                textColor: Colors.green,
                                size: 14,
                                weight: FontWeight.w700),
                          ),*/
                                SizedBox(height: 5),
                                Text(
                                  exploreModel.data!.arrMatches![index].title!
                                      .toString(),
                                  style: AppTextStyle(
                                      textColor: Colors.white,
                                      size: 16,
                                      weight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${exploreModel.data!.arrMatches![index].bedroom.toString()}" +
                                      " bhk," +
                                      " ${exploreModel.data!.arrMatches![index].area.toString()}" +
                                      " area",
                                  style: AppTextStyle(
                                    textColor: Colors.white,
                                    size: 13,
                                    weight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${exploreModel.data!.arrMatches![index].subCity.toString()}" +
                                      "  ${exploreModel.data!.arrMatches![index].city.toString()}",
                                  style: AppTextStyle(
                                      textColor: Colors.white,
                                      size: 13,
                                      weight: FontWeight.normal),
                                ),
                              ],
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

                                SizedBox(height: Get.height / 100),

                                // GestureDetector(
                                //   onTap: onShareTap,
                                //   child: Container(
                                //     child: Image.asset("assets/icons/sharenew.png",
                                //         color: Colors.white),
                                //     width: 50,
                                //     height: 40,
                                //   ),
                                // ),

                                SizedBox(height: Get.height / 100),
                                Container(
                                  child: Image.asset("assets/icons/pencil.png",
                                      color: Colors.white),
                                  width: 50,
                                  height: 40,
                                ),
                                SizedBox(height: Get.height / 100),
                                GestureDetector(
                                  onTap: onInformationTap,
                                  child: Container(
                                    child: Image.asset("assets/icons/share.png",
                                        color: Colors.white),
                                    width: 50,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(height: Get.height / 100),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: Get.height / 50,),
                      GestureDetector(
                        onTap: onShortlistTap,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
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
                              Icon(Icons.save_alt, color: ColorRes.btnBg),
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
                      ),
                      SizedBox(height: 75),
                    ],
                  ),
                )),
          ],
        );
}
