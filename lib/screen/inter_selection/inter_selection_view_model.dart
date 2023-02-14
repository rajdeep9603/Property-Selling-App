import 'dart:convert';
import 'package:com.propacy.b2c/model/get_bg_image_model.dart';
import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/rest_api/get_preference_api.dart';
import 'package:com.propacy.b2c/rest_api/get_zones_areas_api.dart';
import 'package:com.propacy.b2c/rest_api/post_preference_api.dart';
import 'package:com.propacy.b2c/screen/authorization/enter_mobile_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/bottom_part.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_splash/vidio_splash_screen.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

void logout() async {
  FirebaseAuth.instance.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  var checkIsProceedTap = prefs.getString("isProceedTap");
  print("____*****____checkIsProceedTap_____*******" +
      checkIsProceedTap.toString());
  print(isProceedTap);
  print(isThisScreenFromProfile);
  isProceedTap = false;
  Get.offAll(() => EnterMobileScreen());
}

class InterSelectionViewModel extends BaseViewModel {
  String? element;
  GetZonesModel zoneModel = GetZonesModel();

  // GetPreferenceModel preferenceModel = GetPreferenceModel();
  PostPreferenceModel postPreferenceModelData = PostPreferenceModel();
  int? min;
  int? max;
  int? jump;
  int? temp;
  bool stackLineShow = true;
  bool settingTap = false;
  int isSelected = 0;

  //for video-splash
  // bool isShowVideoSplashScreen=true;

  void init(model) async {
    // String cust;
    // cust=  SharePref.getString("loginCustomerId").toString();
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.load, Str.lPreference_statement_page);
    showPop = true;
    setBusy(true);
    if (preferenceModel.data != null) {
      print("PREFERENCE MODEL HAS ALREADY DATA");
    } else {
      getPreferenceApi(model);
    }

    if (bgImages.isNotEmpty) {
      print("IMAGES ARE : " + bgImages.toString());
    } else {
      print("CALL IMAGE API");
      getBgImage();
    }

    if (isThisScreenFromProfile == true) {
      await getLocalStoreData();
    }

    loginHasPref ? getAreasFromLogin() : getAreasFromLocalStorage();
    Future.delayed(100.milliseconds, () {
      isTopCollapsed = false;
      notifyListeners();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // occupationName = prefs.getString("userProfile");
    logCustomerId = prefs.getString("loginCustomerId");
    settingTap = prefs.getBool("onTapProfile") ?? false;
    print("settingTap : $settingTap , logCustomerId : $logCustomerId");

    setBusy(false);
  }

  Future<void> getAreasFromLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ab2 = prefs.getStringList("SelectedArea")!;
    print("FirstTimeArea=====>");
    print(ab2);
    if (ab2.isEmpty) {
      ab2 = [];
    }
    if (ab2.isNotEmpty) {
      if (ab2.length > 0) {
        locOnTap = ab2[0];
      } else {
        locOnTap = "Multiple";
      }
    }
  }

  Future<void> getAreasFromLocalStorage() async {
    ab = [];
    //final String? encodeLoc = await SharePref.getStringLi("SelectedArea");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ab = prefs.getStringList("SelectedArea")!;
//    ab = jsonDecode(encodeLoc!);
    print(ab.length);
    if (ab.isNotEmpty) {
      if (ab.length == 1) {
        locOnTap = ab[0].toString();
      } else {
        if (ab.length > 1) locOnTap = "Multiple";
      }
    } else {
      locOnTap = "Select";
    }
    print("LIST YOU WANT FROM LOCAL STORAGE " + ab.toString());
  }

  Future<void> getLocalStoreData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    occupationName = prefs.getString("userProfile") ;
    radio1 = prefs.getString("intent") ;
    radioReadytomove = prefs.getString("ReadyToMove");
    selectedApartment = prefs.getString("category") ;
    displayCat = prefs.getStringList("displayCat") ??
        ["Apartment"]; //todo:Apartment for null
    print(displayCat);
    localityFromTap = prefs.getString("LocMultiple");
    furnishTypeFromTap = prefs.getString("furnishType");
    selectedbhk = prefs.getString("bedRoom");
    displayBedRooms = prefs.getStringList("displayBedRooms") ?? ["1"];
    selectedMinPrize = prefs.getString("minPrice")?? "80.0 Lac";
    selectedMaxPrize = prefs.getString("maxPrice") ?? "90.0 Lac";
    range3 = "$selectedMinPrize - $selectedMaxPrize";
    print(range3 + "FROM STORAGE");
    notifyListeners();


    var encodedMap = prefs.getString('postCatMap');
    categoryMap = json.decode(encodedMap!);
    print("FROM LOCAL STORAGE CATEGORY" + categoryMap.toString());

    var encodedMapFurnish = prefs.getString('postFurnishMap');
    furnishTypesMap = await json.decode(encodedMapFurnish!);
    print("FROM LOCAL STORAGE FURNISH TYPES" + furnishTypesMap.toString());

    var encodedMapBedRoom = prefs.getString('postBedRoomMap');
    bedRoomMap = await json.decode(encodedMapBedRoom!);
    print("FROM LOCAL STORAGE BEDROOMS" + bedRoomMap.toString());
    notifyListeners();

    print("LOCALITY GET LIST == > >" + localityFromTap);
  }

  GetBgImageModel bgModel = GetBgImageModel();

  Future<void> getBgImage() async {
    // String?image = await BackgroungImageApi.bgImageApi();
    // element = image;
    // notifyListeners();
    setBusy(true);
    await BackgroungImageApi.bgImageApi().then((val) {
      setBusy(false);
      bgModel = val;
      print(bgModel.toString());
      bgImages = bgModel.data!.images!;
      element = getRandomElement(bgImages);
      print(getRandomElement(bgImages));
      print("===images===>  " + element.toString());
      notifyListeners();
    });
  }

  getPreferenceApi(InterSelectionViewModel model) async {
    setBusy(true);
    await GetPreference.getPreference().then((value) {
      setBusy(false);
      preferenceModel = value!;
      print(preferenceModel);
      print(preferenceModel.data!.occupation!.length);
      min = int.parse(preferenceModel.data!.min!.numberDouble
          .toString()
          .split(".")
          .first
          .toString());
      max = int.parse(preferenceModel.data!.max!.numberDouble
          .toString()
          .split(".")
          .first
          .toString());
      jump = int.parse(preferenceModel.data!.jump!.numberDouble
          .toString()
          .split(".")
          .first
          .toString());
      temp = min;
      print("MIN VALUE  ::  $min");
      print("MAX VALUE  ::  $max");
      print("JUMP VALUE  :: $jump");

      propertyRangeList.clear();
      // propertyRangeList.add("1 K");
      for (int i = min!; i < max!; i = i + jump!) {
        if (i >= 10000000) {
          double d = i / 10000000;
          if (propertyRangeList.contains(
              d.toString() /*.split(".").first.toString()*/ + " Cr")) {
            propertyRangeList
                .remove(d.toString() /*.split(".").first.toString()*/ + " Cr");
            propertyRangeList
                .add(d.toString() /*.split(".").first.toString()*/ + " Cr");
          } else {
            propertyRangeList
                .add(d.toString() /*.split(".").first.toString()*/ + " Cr");
          }
        } else if (i >= 100000) {
          double d = i / 100000;
          if (propertyRangeList
              .contains(d.toString()/*.split(".").first.toString()*/ + " Lac")) {
            propertyRangeList
                .remove(d.toString()/*.split(".").first.toString()*/ + " Lac");
            propertyRangeList
                .add(d.toString()/*.split(".").first.toString()*/ + " Lac");
          } else {
            propertyRangeList
                .add(d.toString()/*.split(".").first.toString()*/ + " Lac");
          }
        } else if (i >= 1000) {
          double d = i / 1000;
          if (propertyRangeList
              .contains(d.toString().split(".").first.toString() + " K")) {
            propertyRangeList
                .remove(d.toString().split(".").first.toString() + " K");
            propertyRangeList
                .add(d.toString().split(".").first.toString() + " K");
          } else {
            propertyRangeList
                .add(d.toString().split(".").first.toString() + " K");
          }
        }
      }
      if (max! >= 10000000) {
        double d = max! / 10000000;
        if (propertyRangeList
            .contains(d.toString() /*.split(".").first.toString()*/ + " Cr")) {
          propertyRangeList
              .remove(d.toString() /*.split(".").first.toString()*/ + " Cr");
          propertyRangeList
              .add(d.toString() /*.split(".").first.toString()*/ + " Cr");
        } else {
          propertyRangeList
              .add(d.toString() /*.split(".").first.toString()*/ + " Cr");
        }
      } else if (max! >= 100000) {
        double d = max! / 100000;
        if (propertyRangeList
            .contains(d.toString()/*.split(".").first.toString()*/ + " Lac")) {
          propertyRangeList
              .remove(d.toString()/*.split(".").first.toString()*/ + " Lac");
          propertyRangeList
              .add(d.toString()/*.split(".").first.toString()*/ + " Lac");
        } else {
          propertyRangeList
              .add(d.toString()/*.split(".").first.toString()*/ + " Lac");
        }
      } else if (max! >= 1000) {
        double d = max! / 1000;
        if (propertyRangeList
            .contains(d.toString().split(".").first.toString() + " K")) {
          propertyRangeList
              .remove(d.toString().split(".").first.toString() + " K");
          propertyRangeList
              .add(d.toString().split(".").first.toString() + " K");
        } else {
          propertyRangeList
              .add(d.toString().split(".").first.toString() + " K");
        }
      }
      notifyListeners();
    });

    // categories=preferenceModel.data!.category!;
    preferenceModel.data!.category!.forEach((element) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      categoriesList.add(element);
      notifyListeners();
      //  var isProceedTap=prefs.getBool("isProceedTap");
      if (isProceedTap == true) {
        var encodedMap = prefs.getString('postCatMap');
        categoryMap = json.decode(encodedMap!);
        print(categoryMap);
      } else if (categoryMap.containsKey(element) == false) {
        categoryMap.addAll({element: false});
      }
      // print("CATEGORY MAP ===> "+categoryMap.toString());
      // print("CATEGORIES LIST ====>  " + categoriesList.toString());
    });

    preferenceModel.data!.furnishType!.forEach((ele) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      furnishTypesList.add(ele);
      notifyListeners();
      if (isProceedTap == true) {
        var encodedMapFurnish = prefs.getString("postFurnishMap");
        furnishTypesMap = json.decode(encodedMapFurnish!);
        print(furnishTypesMap);
      } else if (furnishTypesMap.containsKey(ele) == false) {
        furnishTypesMap.addAll({ele: false});
      }
      // print("FURNISH TYPE MAP ===> "+furnishTypesMap.toString());
      // print("FURNISH TYPE LIST ====>  " + furnishTypesList.toString());
    });

    preferenceModel.data!.bedrooms!.forEach((ele) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bedRoomList.add(ele);
      notifyListeners();
      if (isProceedTap == true) {
        var encodedMapBedRoom = prefs.getString("postBedRoomMap");
        bedRoomMap = json.decode(encodedMapBedRoom!);
        print(encodedMapBedRoom);
      } else if (bedRoomMap.containsKey(ele) == false) {
        bedRoomMap.addAll({ele: false});
      }
      // print("BedRoom MAP ===> "+bedRoomMap.toString());
      // print("BedRoom LIST ====>  " + bedRoomList.toString());
    });
  }

  bool showProfessional = false;
  bool questionTap = false;
  bool showOnBuy = false;
  bool propertyShow = false;
  bool selectArea = false;
  bool isbhkTap = false;
  bool isApartment = false;
  List<String> propertyRangeList2 = [];

  Future<void> onProfessionalTap() async {
    // settingTap=false;
    loginHasPref = false;
    // isThisScreenFromProfile = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userProfile");
    print("REMOVE USERPROFILE");
    var check = prefs.getString("userProfile");
    print("CHECK REMOVE OR NOt " + check.toString());
    showProfessional = !showProfessional;
    print("SHOW PROFESSIONAL ---" + showProfessional.toString());
    print("SHOW Proceed ---" + isProceedTap.toString());
    if (isProceedTap == true) {
      settingTap = !showProfessional;
    } else {
      settingTap = false;
    }
    print("SHOW SETTINGTAP ---" + settingTap.toString());
    notifyListeners();
    // getBgImage();
    element = getRandomElement(bgImages);
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.click, Str.lPreferences_userType_dropdown);
    notifyListeners();
  }

  propertyRangeTap() async {
    showPop = false;
    loginHasPref = false;
    loginArea = false;
    localArea = false;
    isThisScreenFromProfile = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    minP = prefs.getString("minPrice") ?? "80.0 Lac";
    maxP = prefs.getString("maxPrice") ?? "90.0 Lac";
    // prefs.remove("minPrice");
    // prefs.remove("maxPrice");
    propertyShow = !propertyShow;
    settingTap = !propertyShow;
    notifyListeners();
    // getBgImage();
    element = getRandomElement(bgImages);
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.click, Str.lPreferences_price_dropdown);
    notifyListeners();
  }

  Future<void> onBuyTap() async {
    showPop = false;
    loginHasPref = false;
    isThisScreenFromProfile = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("ReadyToMove");
    prefs.remove("ReadyToMove");
    showOnBuy = !showOnBuy;
    settingTap = !showOnBuy;
    notifyListeners();
    // getBgImage();
    element = getRandomElement(bgImages);
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.click, Str.lPreferences_propType_dropdown);
    notifyListeners();
  }

  Future<void> onApartmentTap1() async {
    showPop = false;
    loginHasPref = false;
    isThisScreenFromProfile = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("category");
    prefs.remove("category");
    prefs.remove("postCatMap");
    showOnBuy = !showOnBuy;
    settingTap = !showOnBuy;
    notifyListeners();
    element = getRandomElement(bgImages);
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.click, Str.lPreferences_category_dropdown);
    notifyListeners();
  }

  Future<void> onQuestionTap() async {
    questionTap = !questionTap;
    notifyListeners();
    // getBgImage();
    element = getRandomElement(bgImages);
    notifyListeners();
  }

  Future<void> bhkTap() async {
    showPop = false;
    loginHasPref = false;
    isThisScreenFromProfile = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("bedRoom");
    prefs.remove("postBedRoomMap");
    isbhkTap = !isbhkTap;
    settingTap = !isbhkTap;
    notifyListeners();
    // getBgImage();
    element = getRandomElement(bgImages);
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.click, Str.lPreferences_bedroom_dropdown);
    notifyListeners();
  }

  Future<void> readyToMove() async {
    showPop = false;
    loginHasPref = false;
    isThisScreenFromProfile = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("type");
    prefs.remove("postFurnishMap");

    // prefs.remove("category");
    // prefs.remove("postCatMap");
    isApartment = !isApartment;
    settingTap = !isApartment;
    notifyListeners();
    // getBgImage();
    element = getRandomElement(bgImages);
    notifyListeners();
  }

  onProceedTap(BuildContext context) async {
    firstopenvideo = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (loginHasPref == true) {
      if (ab2.isEmpty && ab2.length < 1) {
        Get.snackbar("Error", "Please Select atleast one area",
            backgroundColor: Colors.blue, colorText: Colors.white);
      } else {
        isProceedTap = true;
        loginHasPref = false;
        prefs.setStringList("SelectedArea", ab2);
        // setBusy(true);
        // SharePref.setBool("ShowVideoSplash", isShowVideoSplashScreen);
        await PostPreferenceApi.postPrefenceApi().then((value) async {
          postPreferenceModelData = value!;
          notifyListeners();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("isProceedTap", isProceedTap);
          SharePref.setString(
              "postModel", jsonEncode(postPreferenceModelData.toJson()));
          // Get.to(()=>VidioSplashScreen(postPreferenceModelData:postPreferenceModelData));
          //for video-splash
          // isShowVideoSplashScreen= await SharePref.getBool("ShowVideoSplash") ?? true;
          // print(isShowVideoSplashScreen);
          // isShowVideoSplashScreen? Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeft,
          //         child: VidioSplashScreen(
          //             postPreferenceModelData: postPreferenceModelData))):
          // Get.off(()=>VidioScreen(feedModel: postPreferenceModelData,));
          Get.off(() => VidioScreen(
                feedModel: postPreferenceModelData,
              ));
        });
      }
    } else {
      if (ab.isEmpty && ab.length < 1) {
        Get.snackbar("Error", "Please select at least one area");
      } else {
        isProceedTap = true;
        loginHasPref = false;
        prefs.setStringList("SelectedArea", ab);
        await PostPreferenceApi.postPrefenceApi().then((value) async {
          postPreferenceModelData = value!;
          notifyListeners();
          prefs.setBool("isProceedTap", isProceedTap);
          SharePref.setString(
              "postModel", jsonEncode(postPreferenceModelData.toJson()));
          // Get.to(()=>VidioSplashScreen(postPreferenceModelData:postPreferenceModelData));
          //for video-splash
          // isShowVideoSplashScreen= await SharePref.getBool("ShowVideoSplash") ?? true;
          // print(isShowVideoSplashScreen);
          // isShowVideoSplashScreen? Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeft,
          //         child: VidioSplashScreen(
          //             postPreferenceModelData: postPreferenceModelData))):
          // Get.off(()=>VidioScreen(feedModel: postPreferenceModelData,));
          Get.off(() => VidioScreen(
                feedModel: postPreferenceModelData,
              ));
        });
      }
    }
    FirebaseAnalyticsService.sendAnalyticsEvent2(
        Str.cPreferenceAdd, Str.click, Str.lPreferences_sent);
    // notifyListeners();

    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: VidioSplashScreen()));
    // setBusy(true);
    // await PostPreferenceApi.postPrefenceApi().then((value){
    //   setBusy(false);
    //   postPreferenceModelData = value!;
    //   print(postPreferenceModelData);
    //   Get.to(()=>VidioSplashScreen(feedModel:postPreferenceModelData));
    //   notifyListeners();
    // });
  }

  getBackPage() async {
    await PostPreferenceApi.postPrefenceApi().then((value) async {
      postPreferenceModelData = value!;
      notifyListeners();
    }).then((value) {
      Get.off(() => VidioScreen(
            feedModel: postPreferenceModelData,
          ));
    });
  }

  areaSelectTap() async {
    // loginHasPref = false;
    setBusy(true);
    showPop = false;
    stackLineShow = false;
    isThisScreenFromProfile = false;
    selectArea = !selectArea;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("locality");
    prefs.remove("localities");
    await GetZonesApi.getZones().then((value) {
      setBusy(false);
      print(value);
      zoneModel = value!;
      print(zoneModel);
      notifyListeners();
    });
    // notifyListeners();
  }

  String idx = SharePref.getString("ind").toString();

  List<String>? occupation = [
    "Profession",
    "Business person",
    "Student",
    "Home maker",
    "Retired"
  ];

  List<String> whiteIcon = [
    "assets/icons/w_prof.png",
    "assets/icons/w_business.png",
    "assets/icons/w_student.png",
    "assets/icons/w_home.png",
    "assets/icons/w_retired.png",
  ];

  Future<void> selectedItemIndex(int index) async {
    isSelected = index;

    notifyListeners();
    print("INDEX " + isSelected.toString());
  }

  //for animation
  // bool isLeftCollapsed = true;
  // bool isRightCollapsed = true;
  bool isTopCollapsed = true;

  // bool isBottomCollapsed = true;
  // late double screenWidth, screenHeight;
  final Duration duration = const Duration(seconds: 3);
  late AnimationController controller;

// @override
// void dispose() {
//   controller!.dispose();
//   super.dispose();
// }
}
