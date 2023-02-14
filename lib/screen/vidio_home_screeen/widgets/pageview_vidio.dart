// import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/start_vidio_screen.dart';
// import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/stop_vidio_screen.dart';
// import 'package:com.propacy.b2c/utils/app.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class PageViewVidio extends StatefulWidget {
//   String?link;
//   PageViewVidio({this.link});
//   @override
//   _PageViewVidioState createState() => _PageViewVidioState();
// }
//
// class _PageViewVidioState extends State<PageViewVidio> {
//
//
//   int? currPage = 0;
//   bool isClicked = false;
//
//   bool isVidioShow = false;
//   bool isPlayHide = false;
//   bool isPauseHide = false;
//   late PlayerState playerState;
//   late YoutubeMetaData videoMetaData;
//   String? vidioUrl;
//   String? selectedTab = AppRes.foryou;
//   YoutubePlayerController? controller;
//   double _volume = 100;
//   bool isPlayerReady = false;
//   bool? isPlay = false;
//   bool muted = false;
//
//
//   void runYouTubePlayer(){
//     controller = YoutubePlayerController(
//       initialVideoId:YoutubePlayer.convertUrlToId(widget.link!).toString(),
//       flags:YoutubePlayerFlags(
//         autoPlay: false,
//         isLive: true,
//         enableCaption: true,
//       ),
//     )..addListener(listener);
//     videoMetaData = const YoutubeMetaData();
//     playerState = PlayerState.unknown;
//   }
//
//   void listener() {
//     if (isPlayerReady && !controller!.value.isFullScreen) {
//       playerState = controller!.value.playerState;
//       videoMetaData = controller!.metadata;
//       setState(() {});
//     }
//   }
//
//
//
//
//   @override
//   void initState() {
//     runYouTubePlayer();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//       player: YoutubePlayer(
//         onReady: () {
//           isPlayerReady = true;
//         },
//         onEnded: (data) {
//           controller!
//               .reload();
//         },
//         width: Get.width,
//         // progressColors: Meteria,
//
//         progressIndicatorColor: Colors.red,
//         showVideoProgressIndicator: true,
//         controller: controller!,
//       ),
//       builder: (context, player) {
//         return isVidioShow == false ? stopVidioScreen(
//             player, model) : startVidioScreen(player, model);
//         // return Scaffold(
//         // backgroundColor: ColorRes.black,
//         // bottomNavigationBar: model.isVidioShow == false
//         //     ? bottemBarStopVidio()
//         //     : vidioShowBottemBar(model),
//         // body:
//         // body:stopVidioScreen(player, model)
//         // );
//       },
//     );
//   }
// }
