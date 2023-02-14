import 'dart:convert';
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/rest_api/post_preference_api.dart';
import 'package:com.propacy.b2c/screen/authorization/enter_mobile_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  PostPreferenceModel? postPreferenceModelData;

  init() {
    getPreferenceLogin();
  }

  getPreferenceLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkUid = await prefs.getString("userId");
    //checkUid="QzzDuVuMV9bLfOD5XAfreYXGoLp2";
    isProceedTap = prefs.getBool("isProceedTap") ?? false;
    var isLogin = await prefs.getBool("isLogin");
    if (isProceedTap == true) {
      getModel();
    } else {
      Future.delayed(const Duration(milliseconds: 5000), () {
        // Get.off(()=>     VidioScreen(feedModel: postPreferenceModelData ==null ?null:postPreferenceModelData,));
        Get.off(() => checkUid == null
            ? EnterMobileScreen()
            : isProceedTap
                ? VidioScreen(
                    feedModel: postPreferenceModelData == null
                        ? null
                        : postPreferenceModelData,
                  )
                : InterSelectionScreen());
        // Get.off(()=>VidioScreen(feedModel: postPreferenceModelData ==null ?null:postPreferenceModelData,));
      });
    }
    isThisScreenFromProfile = prefs.getBool("onTapProfile") ?? false;
    if (isThisScreenFromProfile == true) {
      await getLocalStoreData();
    }
    print(checkUid);
    print(isProceedTap);
    print(isLogin);
    notifyListeners();
  }

  Future<void> getLocalStoreData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    occupationName = prefs.getString("userProfile"); //done
    radio1 = prefs.getString("intent");
    radioReadytomove = prefs.getString("ReadyToMove");
    selectedApartment = prefs.getString("category") /*?? "ApartMent"*/;
    displayCat = prefs.getStringList("displayCat")!;
    furnishTypeFromTap = prefs.getString("furnishType");
    selectedbhk = prefs.getString("bedRoom");
    displayBedRooms = prefs.getStringList("displayBedRooms")!;
    selectedMinPrize = prefs.getString("minPrice");
    selectedMaxPrize = prefs.getString("maxPrice");
    range3 = "$selectedMinPrize  - $selectedMaxPrize";
    notifyListeners();

    var encodedMap = prefs.getString('postCatMap');
    categoryMap = json.decode(encodedMap!);
    print(categoryMap.toString());
    print("FROM LOCAL STORAGE IN  MAIN" + categoryMap.toString());

    var encodedMapFurnish = prefs.getString('postFurnishMap');
    furnishTypesMap = json.decode(encodedMapFurnish!);
    print("FROM LOCAL STORAGE FURNISH TYPES" + encodedMapFurnish.toString());

    var encodedMapBedRoom = prefs.getString('postBedRoomMap');
    bedRoomMap = json.decode(encodedMapBedRoom!);
    print("FROM LOCAL STORAGE BEDROOMS" + encodedMapBedRoom.toString());

    print("LOCALITY GET LIST == > >" + localityFromTap);
  }

  Future<void> getModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("isLogin");
    isProceedTap = prefs.getBool("isProceedTap") ?? false;
    if (isProceedTap == true) {
      firstopenvideo = true;
      PostPreferenceApi.postPrefenceApi().then((value) async {
        postPreferenceModelData = value!;
      }).then((value) {
        Future.delayed(const Duration(milliseconds: 5000), () {
          // Get.off(()=>     VidioScreen(feedModel: postPreferenceModelData ==null ?null:postPreferenceModelData,));
          Get.off(() => checkUid == null
              ? EnterMobileScreen()
              : isProceedTap
                  ? VidioScreen(
                      feedModel: postPreferenceModelData == null
                          ? null
                          : postPreferenceModelData,
                    )
                  : InterSelectionScreen());
          // Get.off(()=>VidioScreen(feedModel: postPreferenceModelData ==null ?null:postPreferenceModelData,));
        });
      });

      // String? model = await SharePref.getString("postModel");
      // print("model"+model.toString());
      // if(model != null){
      //   postPreferenceModelData = postPrefenceModelFromJson(model);
      // }
      notifyListeners();
    }
  }

// Future<void>getBgImage() async {
//   String? image = await BackgroungImageApi.bgImageApi();
//   element = image;
//   notifyListeners();
// }
}
