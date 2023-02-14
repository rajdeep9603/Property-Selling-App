import 'package:com.propacy.b2c/model/chat_model/chat_api_resp_model.dart';
import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/model/user_model/user_model.dart';
import 'package:com.propacy.b2c/rest_api/chat_api.dart';
import 'package:com.propacy.b2c/rest_api/post_explore_vidioes_api.dart';

import 'package:com.propacy.b2c/rest_api/post_preference_api.dart';
import 'package:com.propacy.b2c/screen/chat/chat_home_page/chat_home_page.dart';
import 'package:com.propacy.b2c/screen/chat/chat_screen/chat_screen.dart';

// import 'package:com.propacy.b2c/screen/chat/chat_home_page/chat_home_page.dart';

import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/property_details/property_details_screen.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/widgets/bottom_schedule_buttons.dart';
import 'package:com.propacy.b2c/services/chat_service/chat_service.dart';
import 'package:com.propacy.b2c/share_screen.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
List<bool> isForuLoad=[true];
List<bool> isExpLoad=[];
class ExploreVidioViewModel extends BaseViewModel {
  // PostPreferenceModel feedModel = PostPreferenceModel();

  PostExploreVideoModel exploreModel = PostExploreVideoModel();

  late PageController pageController;
  late PageController explorePageController = PageController();

  bool scroll = false;

  int currPage = 0;
  bool isClicked = false;

  List<bool> isVidioShow = [];
  bool isPlayHide = false;
  bool isPauseHide = false;

  // List<PlayerState> playerState = [];
  // List<PlayerState> playerStateExplore = [];
  // List<YoutubeMetaData> videoMetaDataExplore = [];
  // List<YoutubeMetaData> videoMetaData = [];
  String? vidioUrl;
  String? selectedTab = AppRes.foryou;
  List<YoutubePlayerController> controller = [];
  List<YoutubePlayerController> controllerExplore = [];
  double _volume = 100;
  bool isPlayerReady = false;
  bool? isPlay = false;
  bool muted = false;
  int indexBottem = 0;
  List<String> imgUrl = [];
  List<String> exploreImgUrl = [];
  List<String> videoUrl = [];
  bool isLoading = true;

  YoutubePlayerController? youtubePlayerController;


  bool isShortListed = false;
  bool notDataAvailable = false;
  bool exploreLoader = false;
  int pageIndex = 0;
  ChatApiResponseModel? chatApiResponseModel;
  List<bool> showPlaceHolder = [true];
  bool shortListLoader = false;

  bool showShortList = false;
  bool showBottomNavigationBar = true;
  bool settingTapOfNavigation =false;
  // int index = 0;

  init(PostPreferenceModel? feedPreferenceModel) {
    getCustomerId();
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cFeeds, Str.load, Str.lForYou_page);
    closePlaceHolder(pageIndex, time: 3500);
    pageController = PageController()..addListener(autoScrollInForYou);
    explorePageController = PageController()..addListener(addVideoInExplore);
    if (feedPreferenceModel!.status == true ||
        feedPreferenceModel.status.toString() == "true") {
      feedModel = feedPreferenceModel;
      // if(feedPreferenceModel == null){
      //   notDataAvailable = true;
      //   notifyListeners();
      // }
      // else{
      //   notDataAvailable = false;
      //   notifyListeners();
      // }
      // getExploreVidioes();
      if (feedModel.data != null) {
        runYouTubePlayer();
      }
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

    getPropertyDetails();
  }

  forYouController(int index) {
    controller[index].value.isPlaying==true
        ? controller[index].pause()
        : controller[index].play();
    if(controller[index].value.isPlaying==true){
      isForuLoad[index]=false;
    }
    else{
      isForuLoad[index]=true;
    }

    Future.delayed(Duration(milliseconds:500 ),(){
      notifyListeners();
    });

  }

  exploreController(int index) {
    controllerExplore[index].value.isPlaying==true
        ? controllerExplore[index].pause()
        : controllerExplore[index].play();

    if(controllerExplore[index].value.isPlaying==true){
      isExpLoad[index]=false;

    }
    else{
      isExpLoad[index]=true;
    }
    Future.delayed(Duration(milliseconds: 200),(){
      notifyListeners();
    });

  }

  getCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logCustomerId = prefs.getString("loginCustomerId");
  }

  void addVideoInExplore() {
    if (explorePageController.position.pixels ==
        explorePageController.position.maxScrollExtent) {
      exploreLoader = true;
      notifyListeners();
      addValue();
    } else {
      //double pixel2 = explorePageController.position.pixels - explorePageController.page!.round();
      double pixel =
          explorePageController.page! - explorePageController.page!.round();
      if (isScrolling == false) {
        showPlaceHolder = showPlaceHolder.map<bool>((e) => true).toList();
        notifyListeners();
        if (pixel > 0) {
          if (pageIndex + 1 !=
              (selectedTab == AppRes.foryou
                  ? controller.length
                  : controllerExplore.length)) {
            closePlaceHolder(pageIndex + 1);
          }
          nextPage();
        } else {
          closePlaceHolder(pageIndex - 1);
          prevPage();
        }
      }
    }
  }

  void closePlaceHolder(int index, {int? time}) {
    Future.delayed(Duration(milliseconds: time ?? 3500), () {
      showPlaceHolder[index] = false;
      notifyListeners();
    });
  }

  autoScrollInForYou() {
    double pixel = pageController.page! - pageController.page!.round();
    if (isScrolling == false) {
      showPlaceHolder = showPlaceHolder.map<bool>((e) => true).toList();
      if (pixel > 0) {
        if (pageIndex + 1 != controller.length) {
          closePlaceHolder(pageIndex + 1);
        }
        nextPage();
      } else {
        closePlaceHolder(pageIndex - 1);
        prevPage();
      }
    }
  }

  void addValue() {
    ExplorePostVidioesApi.postExploreApi().then((value) {
      setBusy(false);
      //exploreModel = value!;
      value!.data!.arrMatches!.forEach((element) {
        exploreModel.data!.arrMatches!.add(element);
      });
      print(value.data!.arrMatches!.length);
      print(exploreModel.data!.arrMatches!.length);
      runYouTubePlayerExplore(value);
      exploreLoader = false;
      notifyListeners();
    });
  }

  getPropertyDetails() async {
    setBusy(true);
    isLoading = true;
  }

  //
  // void dispose() {
  //   super.dispose();
  //   _controller.pause();
  //   _controller.dispose();
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //
  //   controller[index].pause();
  //   controller[index].dispose();
  // }
  // int index = 0;
  void runYouTubePlayer() {
    isForuLoad=[];
    // Loader().showLoader();
    int index = 0;
    // isVidioShow = [];
    // controller = [];
    // playerState = [];
    // videoMetaData = [];
    feedModel.data!.arrMatches!.forEach((e) {
      e.images!.forEach((element) {
        imgUrl.add(element.link!);
        isVidioShow.add(false);
      });
    });
    feedModel.data!.arrMatches!.forEach((arrMatches) {
      arrMatches.videos!.forEach((video) {
        // Loader().hideLoader();
        isVidioShow.add(false);
        videoUrl.add(video.link!);
        final List<String> list = List.generate(10,
            (index) => YoutubePlayer.convertUrlToId(video.link!).toString());
        controller.add(YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(video.link!).toString(),
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            disableDragSeek: false,
            loop: true,
            isLive: false,
            forceHD: false,
            enableCaption: false,
            hideControls: true,
          ),
          /*   params: YoutubePlayerParams(
            showControls: false,
            autoPlay: false,
            showFullscreenButton: false,
            loop: true,
            enableCaption: false,
            showVideoAnnotations: false,
            privacyEnhanced: true,
            playsInline: true,
            playlist: list,
          ),*/
        ));
        if(controller.isNotEmpty){
          controller.forEach((element) {
            element.reset();
          });
        }

        showPlaceHolder.add(true);

        // Loader().hideLoader();
        index++;
        //videoMetaData.add(YoutubeMetaData());
        //playerState.add(PlayerState.unknown);
      });
    });
    controller.forEach((element) {
      isForuLoad.add(true);
    });
    // notifyListeners();
  }

  void runYouTubePlayerExplore(PostExploreVideoModel exploreModel) {

    // Loader().showLoader();
    if (exploreModel.data == null) {
      return;
    }
    exploreModel.data!.arrMatches!.forEach((e) {
      e.images!.forEach((element) {
        exploreImgUrl.add(element.link!);
        isVidioShow.add(false);
      });
    });
    isExpLoad=[];
    exploreModel.data!.arrMatches!.forEach((arrMatches) {
      arrMatches.videos!.forEach((video) {

        // Loader().hideLoader();
        isVidioShow.add(false);
        final List<String> list = List.generate(10,
            (index) => YoutubePlayer.convertUrlToId(video.link!).toString());
        controllerExplore.add(YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(video.link!).toString(),
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            disableDragSeek: false,
            loop: true,
            isLive: false,
            forceHD: false,
            enableCaption: false,
            hideControls: true,
          ),
          /*      params: YoutubePlayerParams(
            showControls: false,
            autoPlay: true,
            showFullscreenButton: false,
            loop: true,
            enableCaption: false,
            showVideoAnnotations: false,
            privacyEnhanced: true,
            playsInline: true,
            playlist: list,
          ),*/
        ));
        showPlaceHolder.add(true);

        if(controllerExplore.isNotEmpty)
          controllerExplore[0].reset();
        controllerExplore.forEach((element) {
          element.reset();
        });

        // Loader().hideLoader();
        //videoMetaDataExplore.add(YoutubeMetaData());
        //playerStateExplore.add(PlayerState.unknown);
      });
    });
    notifyListeners();
    print("item"+isExpLoad.length.toString());
    controllerExplore.forEach((element) {
      isExpLoad.add(true);
    });
  }

  getExploreVidioes() async {
    setBusy(true);
    notifyListeners();
    await ExplorePostVidioesApi.postExploreApi().then((value) {
      exploreModel = value!;
      controllerExplore = [];
      runYouTubePlayerExplore(exploreModel);
      notifyListeners();
      if (value.data!.arrMatches!.length == 1) {
        getExploreVidioes();
      }
    });
    setBusy(false);
    notifyListeners();
  }

  //stop vidio function
  void onForyouTap() {
    print("FOR YOU PAGE");
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cFeeds, Str.click, Str.lForYou_page);
    selectedTab = AppRes.foryou;
    onChanged(0);
    if(controller.isNotEmpty){
      controller.forEach((element) {
        element.reset();
      });

    }
    if (showPlaceHolder.length - 1 < pageIndex) {
      showPlaceHolder.add(true);
    } else {
      showPlaceHolder = showPlaceHolder.map<bool>((e) => true).toList();
    }
    notifyListeners();
    closePlaceHolder(pageIndex, time: 3500);
  }

  exploreOnTap() {
    print("EXPLORE PAGE LOAD");
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cFeeds, Str.click, Str.lExplore_page);
    selectedTab = AppRes.explore;

    // Get.to(()=>ExploreVidioScreen());
    if (showPlaceHolder.length - 1 < pageIndex) {
      showPlaceHolder.add(true);
    } else {
      showPlaceHolder = showPlaceHolder.map<bool>((e) => true).toList();
    }
    notifyListeners();
    getExploreVidioes();
    onChangedExlore(0);

    closePlaceHolder(pageIndex, time: 4000);
    notifyListeners();
  }

  void stoppausePlayOnTap(bool play) {
    isClicked = true;
    int index = selectedTab == AppRes.foryou
        ? pageController.page!.round()
        : explorePageController.page!.round();
    if (play == true) {
      isVidioShow[index] = false;
      controller[index].pause();
      notifyListeners();
    } else {
      isPlayHide = true;
      isPauseHide = true;
      isVidioShow[pageController.page!.round()] = true;
      controller[pageController.page!.round()].play();
      notifyListeners();
    }
  }

  void onShortlistTap() {
    int index = selectedTab == AppRes.foryou
        ? pageController.page!.round()
        : explorePageController.page!.round();
    controller[index].pause();
    notifyListeners();
    // onShortlistCalled();
    // Get.back();
    // onShortlistCalled(
    //   date: "2021-09-14T05:24:07.576Z",
    // );
  }

  //
  // onShortlistCalled({
  //   String? date,
  // }) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print("called");
  //   await PostPreferenceApi.shortlist(
  //     status: "A",
  //     date: date,
  //     cId: customerId,
  //     pId:feedModel.result!.arrMatches[index].id,
  //   ).then((value) {
  //     setBusy(false);
  //     isShortListed = value!;
  //     isLoading = false;
  //     notifyListeners();
  //     Timer(Duration(milliseconds: 1000), () {
  //       print("Yeah, this line is printed after 3 seconds");
  //       Get.to(()=>ShortListScreen());
  //     });
  //
  //
  //   });
  // }

  //   onShortlistCalled({
  //   String? date,
  // }) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print("called");
  //   await PostPreferenceApi.shortlist(
  //     status: "A",
  //     date: date,
  //     cId:
  //   ).then((value) {
  //     setBusy(false);
  //     isShortListed = value!;
  //
  //     isLoading = false;
  //     notifyListeners();
  //   });
  // }

  //play vidio function
  void playVidioOnForyouTap() {
    selectedTab = AppRes.foryou;
    notifyListeners();
  }

  void playVidioexploreOnTap() {
    selectedTab = AppRes.explore;
    notifyListeners();
  }

  void playvidioPausePlayOnTap(bool play) {
    isClicked = true;
    int index = selectedTab == AppRes.foryou
        ? pageController.page!.round()
        : explorePageController.page!.round();
    if (play == true) {
      isVidioShow[index] = false;
      controller[index].pause();
      notifyListeners();
    } else {
      isPlayHide = true;
      isPauseHide = true;
      isVidioShow[index] = true;
      controller[index].play();
      notifyListeners();
    }
  }

  //for share
  onShareTap() {
    Get.to(() => WebViewScreen());
    // Share.share("https://www.youtube.com/watch?v=ZIixCOhHQB8");
  }

  Future<void> onInformationTap(int index) async {
    pauseRunningVideo();
    if (selectedTab == AppRes.foryou) {
      FirebaseAnalyticsService.sendAnalyticsEvent3(
          Str.cPropertyDetails,
          Str.click,
          Str.lProperty_detail,
          feedModel.data!.arrMatches![index].id);
      var result = await Get.to(() => PropertyDetailsScreen(
            arr: feedModel.data!.arrMatches![index],
            pId: feedModel.data!.arrMatches![index].id,
            fromVideo: feedModel.data!.arrMatches![index].shortList == true
                ? false
                : true,
          ));
      if (result is bool) {
        if (result) {
          feedModel.data!.arrMatches![index].shortList = result;
        }
      } else if (result is DateTime) {
        feedModel.data!.arrMatches![index].dtmSchedule = result;
        feedModel.data!.arrMatches![index].tourType = 'physicaltour';
      }
      notifyListeners();
    } else {
      FirebaseAnalyticsService.sendAnalyticsEvent3(
          Str.cPropertyDetails,
          Str.click,
          Str.lProperty_detail,
          exploreModel.data!.arrMatches![index].id);
      var result = await Get.to(() => PropertyDetailsScreen(
            arr: exploreModel.data!.arrMatches![index],
            pId: exploreModel.data!.arrMatches![index].id,
            fromVideo: exploreModel.data!.arrMatches![index].shortList == true
                ? false
                : true,
          ));
      if (result is bool) {
        if (result) {
          exploreModel.data!.arrMatches![index].shortList = result;
        }
      } else if (result is DateTime) {
        exploreModel.data!.arrMatches![index].dtmSchedule = result;
        exploreModel.data!.arrMatches![index].tourType = 'physicaltour';
      }
      notifyListeners();
    }
  }

  void stopSoundOnOff() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cFeeds, Str.click, Str.lSound_on_off);
    muted = !muted;
    if (muted == false) {
      controller[pageController.page!.round()].unMute();
      //controllerExplore[pageController.page!.round()].unMute();
    } else {

      controller[pageController.page!.round()].mute();
      //controllerExplore[pageController.page!.round()].mute();
    }

    notifyListeners();
    /*if (isPlayerReady) {
      muted = !muted;
      muted == false
          ? controller[pageController.page!.round()].unMute()
          : controller[pageController.page!.round()].mute();
      notifyListeners();
    } else {
      isPlayerReady = false;
      notifyListeners();
    }*/
  }

  void playSoundOnOff() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cFeeds, Str.click, Str.lSound_on_off);
    muted = !muted;
    if (muted == false) {
      controllerExplore[explorePageController.page!.round()].unMute();
    } else {
      controllerExplore[explorePageController.page!.round()].mute();
    }
    notifyListeners();
    /*if (isPlayerReady) {
      muted = !muted;
      muted == false
          ? controller[pageController.page!.round()].unMute()
          : controller[pageController.page!.round()].mute();
      notifyListeners();
    } else {
      isPlayerReady = false;
      notifyListeners();
    }*/
  }

  onChanged(int index) {
    pageIndex = index;
    if (controller.isNotEmpty) {
      controller[index].reset();

      controller.forEach((element) {
        element.reset();
      });
      isForuLoad.forEach((element) {
        element=true;
      });
      Future.delayed(Duration(seconds: 3), () {
        if (controller[index].value.isPlaying == false) {
          //controller[index].play();

        }
      });
    }

    Future.delayed((2000.milliseconds), () {
      if (controller.length != 0) {
        if (muted == false) {
          controller[index].unMute();
        } else {
          controller[index].mute();
        }
      }
      notifyListeners();
    });
  }

  onChangedExlore(int index) {
    pageIndex = index;
    if (controllerExplore.isNotEmpty) {
      controllerExplore[index].reset();
      controllerExplore.forEach((element) {
        element.reset();
      });
      isExpLoad.forEach((element) {
        element=true;
      });
      Future.delayed(Duration(seconds: 3), () {
        if (controllerExplore[index].value.isPlaying == false) {
          //controllerExplore[index].play();
        }
      });
    }

    notifyListeners();

    //controller[index-1].dispose();
    // controller[index-1].reload();
    Future.delayed((2000.milliseconds), () {
      if (exploreModel.data != null && controllerExplore.length != 0) {
        if (muted == false) {
          controllerExplore[index].unMute();
        } else {
          controllerExplore[index].mute();
        }
      }
    });

    notifyListeners();
  }

  void listener(int index) {
    if (isPlayerReady && !controller[index].value.isFullScreen) {
      //playerState[index] = controller[index].value.playerState;
      //videoMetaData[index] = controller[index].metadata;
      notifyListeners();
    }
  }

  void onHomeTap() {
    showShortList = false;
    showBottomNavigationBar = true;
    settingTapOfNavigation =false;
    indexBottem = 0;
    notifyListeners();
    Get.offAll(() => VidioScreen(
          feedModel: feedModel == null ? null : feedModel,
        ));
  }


  onShortListTap(BuildContext context) {
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cShortlist, Str.click, Str.lProperty_shortlisted);
    showShortList =true;
    showBottomNavigationBar = true;
    settingTapOfNavigation =false;
    indexBottem = 1;
    pauseRunningVideo();

    notifyListeners();
    // Navigator.push(
    //     context,
    //     PageTransition(
    //         type: PageTransitionType.rightToLeft, child: ShortListScreen()));

  }

  Future<void> onSettingTap() async {
    showShortList=false;
    showBottomNavigationBar = false;
    settingTapOfNavigation =true;
    notifyListeners();
    indexBottem = 2;
    lsIsThisScreenFromProfile = true;
    localArea = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("onTapProfile", lsIsThisScreenFromProfile!);
    print("ONTAP PROFILE ===> " + isThisScreenFromProfile.toString());
    isThisScreenFromProfile = prefs.getBool("onTapProfile")!;

    print("isThisScreenFromProfile ++++" + isThisScreenFromProfile.toString());
    Get.to(() => InterSelectionScreen());
    pauseRunningVideo();
    notifyListeners();
  }

  void pauseRunningVideo() {
    if (selectedTab == AppRes.foryou) {
      if (controller.length != 0) {
        controller[pageController.page!.round()].pause();
      }
    } else {
      if (controllerExplore.length != 0) {
        controllerExplore[explorePageController.page!.round()].pause();
      }
    }
  }

  void onChatBtnTap() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cChat, Str.click, Str.lChat_box_page);
    pauseRunningVideo();
    print("propIndex");
    print(pageIndex);
    Get.to(() => ChatHomePage());
/*    if(selectedTab==AppRes.explore){
      print(exploreModel.data!.arrMatches![pageIndex].id.toString());
      ChatApi.chatApiResp(exploreModel.data!.arrMatches![pageIndex].id.toString())
          .then((value) {
        chatApiResponseModel = value;
        Get.to(() => ChatScreen(
          uid: chatApiResponseModel!.data!.buddy!.uid.toString(),
          name: chatApiResponseModel!.data!.buddy!.name!,
        ));
      });
    }
    else{
      print(feedModel.data!.arrMatches![pageIndex].id.toString());
      ChatApi.chatApiResp(feedModel.data!.arrMatches![pageIndex].id.toString())
          .then((value) {
        chatApiResponseModel = value;
        Get.to(() => ChatScreen(
          uid: chatApiResponseModel!.data!.buddy!.uid.toString(),
          name: chatApiResponseModel!.data!.buddy!.name!,
        ));
      });
    }*/
  }

   Future<void> chatview(int index) async {
    if (selectedTab == AppRes.explore) {
      FirebaseAnalyticsService.sendAnalyticsEvent3(
          Str.cChat,
          Str.click,
          Str.lChat_view,
          exploreModel.data!.arrMatches![pageIndex].id.toString());
    print("CHAT ICON TAP");
        // controllerExplore[index].pause();
        // notifyListeners();

      print(exploreModel.data!.arrMatches![pageIndex].id.toString());
      ChatApi.chatApiResp(
              exploreModel.data!.arrMatches![pageIndex].id.toString())
          .then((value) {
        chatApiResponseModel = value;
        // if(controllerExplore[index].value.isPlaying == true){
        //   controllerExplore[index].pause();
        //   notifyListeners();
        // }
        Get.to(() => ChatScreen(
              anpotherPhone:
                  chatApiResponseModel!.data!.buddy!.number.toString(),
              uid: chatApiResponseModel!.data!.buddy!.uid.toString(),
              name: chatApiResponseModel!.data!.buddy!.name!,
              peerType: chatApiResponseModel!.data!.buddy!.memberType,
            ));

        controllerExplore[index].pause();
        isExpLoad[index]=false;
        notifyListeners();
      });

    } else {
      FirebaseAnalyticsService.sendAnalyticsEvent3(Str.cChat, Str.click,
          Str.lChat_view, feedModel.data!.arrMatches![pageIndex].id.toString());
      print("CHAT ICON TAP");
        // controller[index].pause();
        // notifyListeners();
      print(feedModel.data!.arrMatches![pageIndex].id.toString());
      ChatApi.chatApiResp(feedModel.data!.arrMatches![pageIndex].id.toString())
          .then((value) {
        chatApiResponseModel = value;

        Get.to(() => ChatScreen(
              anpotherPhone:
                  chatApiResponseModel!.data!.buddy!.number.toString(),
              uid: chatApiResponseModel!.data!.buddy!.uid.toString(),
              name: chatApiResponseModel!.data!.buddy!.name!,
              peerType: chatApiResponseModel!.data!.buddy!.memberType,
            ));

        controller[index].pause();
        isForuLoad[index]=false;
        notifyListeners();
      });
    }
  }

  Future<void> onShortListBtnTap(int index) async {
    shortListLoader = true;
    pauseRunningVideo();

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString("loginCustomerId");
    if (selectedTab == AppRes.foryou) {
      feedModel.data!.arrMatches![index].shortList = true;
    } else {
      exploreModel.data!.arrMatches![index].shortList = true;
    }
    await PostPreferenceApi.shortlist(
      status: 'A',
      cId: customerId,
      pId: selectedTab == AppRes.foryou
          ? feedModel.data!.arrMatches![index].id!
          : exploreModel.data!.arrMatches![index].id!,
      command: 'shortlist',
      date: DateTime.now().toIso8601String(),
    );
    /*if (selectedTab == AppRes.foryou) {
      feedModel.data!.arrMatches![index].shortList = true;
    } else {
      exploreModel.data!.arrMatches![index].shortList = true;
    }*/
    shortListLoader = false;
    notifyListeners();
  }

  bool isScrolling = false;

  void nextPage() async {
    if (isScrolling == false) {
      isScrolling = true;
      if (selectedTab == AppRes.foryou) {
        await pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      } else {
        await explorePageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
      isScrolling = false;
    }
  }

  void prevPage() async {
    if (isScrolling == false) {
      isScrolling = true;
      if (selectedTab == AppRes.foryou) {
        await pageController.previousPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      } else {
        await explorePageController.previousPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
      isScrolling = false;
    }
  }

  Future<void> onDateSelect(int index, pid) async {
    FirebaseAnalyticsService.sendAnalyticsEvent3(
        Str.cSchedule, Str.click, Str.lPhysical_schedule, pid);
    Get.back();
    shortListLoader = true;
    notifyListeners();

    if (selectedTab == AppRes.foryou) {
      feedModel.data!.arrMatches![index].tourType = "physicaltour";
      feedModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    } else {
      exploreModel.data!.arrMatches![index].tourType = "physicaltour";
      exploreModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    }

    String? propertyId;
    if (selectedTab == AppRes.foryou) {
      propertyId = feedModel.data!.arrMatches![index].id;
    } else {
      propertyId = exploreModel.data!.arrMatches![index].id;
    }

    await onShortlistCalled(
      date: selectedDateVideo!.toIso8601String(),
      status: 'O',
      command: 'physicaltour',
      propertyId: propertyId,
    );
    /*if (selectedTab == AppRes.foryou) {
      feedModel.data!.arrMatches![index].tourType = "physicaltour";
      feedModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    } else {
      exploreModel.data!.arrMatches![index].tourType = "physicaltour";
      exploreModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    }*/
    shortListLoader = false;
    notifyListeners();
  }

  Future<void> onDateUpdate(int index) async {
    Get.back();
    shortListLoader = true;
    notifyListeners();
    String? propertyId;

    if (selectedTab == AppRes.foryou) {
      propertyId = feedModel.data!.arrMatches![index].id;
    } else {
      propertyId = exploreModel.data!.arrMatches![index].id;
    }

    if (selectedTab == AppRes.foryou) {
      feedModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    } else {
      exploreModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    }
    await onShortlistCalled(
      date: selectedDateVideo!.toIso8601String(),
      status: 'O',
      command: 'physicaltour',
      propertyId: propertyId,
    );
    /*if (selectedTab == AppRes.foryou) {
      feedModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    } else {
      exploreModel.data!.arrMatches![index].dtmSchedule = selectedDateVideo;
    }*/
    shortListLoader = false;
    notifyListeners();
  }

  onShortlistCalled({
    String? date,
    String? status,
    String? command,
    String? propertyId,
    // String? status,
  }) async {
    shortListLoader = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString("loginCustomerId");

    await PostPreferenceApi.shortlist(
            status: status,
            date: date,
            cId: customerId,
            pId: propertyId,
            command: command)
        .then((value) {
      setBusy(false);
      isShortListed = value!;
      shortListLoader = false;
      notifyListeners();
      print("Yeah, this line is printed after 3 seconds");
      // Get.to(()=>ShortListScreen());
    });
  }

  String? minPrice(String text) {
    print(text);
    String? minText;
    int minDisplay = int.parse(text.toString());
    if (minDisplay >= 10000000) {
      double d = minDisplay / 10000000;
      minText = d.toString() + " Cr";
    } else if (minDisplay >= 100000) {
      double d = minDisplay / 100000;
      minText = d.toString() + " Lac";
    } else if (minDisplay >= 1000) {
      double d = minDisplay / 1000;
      minText = d.toString() + " K";
    }

    return minText;
  }
}
