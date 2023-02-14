import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/rest_api/post_preference_api.dart';
import 'package:com.propacy.b2c/screen/authorization/enter_mobile_screen_view_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LoginSuccessfullViewModel extends BaseViewModel {
  String? element;
  PostPreferenceModel? postPreferenceModelData;

  init() {
    FirebaseAnalyticsService.sendAnalyticsEvent1(
        Str.cLogin, Str.load, Str.lLogged_successfully_page);
    getdata();
    getBgImage();
    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.to(() => isProceedTap
          ? VidioScreen(
              feedModel: postPreferenceModelData == null
                  ? null
                  : postPreferenceModelData,
            )
          : InterSelectionScreen());
    });
  }

  Future<void> getdata() async {
    if (isProceedTap == true) {
      // setState(() async {
      firstopenvideo = true;
      PostPreferenceApi.postPrefenceApi().then((value) async {
        postPreferenceModelData = value!;
      });
      /* String? model = await SharePref.getString("postModel");
    if(model != null){
      postPreferenceModelData = postPrefenceModelFromJson(model);
      notifyListeners();
    }*/
      // });
    }
  }

  Future<void> getBgImage() async {
    // String? image = await BackgroungImageApi.bgImageApi();
    // element = image;
    // notifyListeners();
    element = getRandomElement(bgImages);
  }
}
