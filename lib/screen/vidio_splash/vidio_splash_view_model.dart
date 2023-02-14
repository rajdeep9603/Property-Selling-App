import 'package:com.propacy.b2c/utils/app.dart';
import 'package:stacked/stacked.dart';

class VidioSplashViewModel extends BaseViewModel {
  String? selectedTab = AppRes.foryou;

  //for video-splash
  // bool isShowVideoSplashScreen = true;
  // PostPreferenceModel postPreferenceModelData = PostPreferenceModel();
  Future<void> init() async {
    //for video-splash
    /*isShowVideoSplashScreen =false;
    SharePref.setBool("ShowVideoSplash", isShowVideoSplashScreen);*/
    // setBusy(true);
    //onTapProfile();
    // Loader().showLoader();
    // await PostPreferenceApi.postPrefenceApi().then((value){
    //   setBusy(false);
    //   // Loader().hideLoader();
    //   postPreferenceModelData = value!;
    //   notifyListeners();
    // });
  }

/*  Future<void> onTapProfile() async {

    // lsIsThisScreenFromProfile = true;
    if(lsIsThisScreenFromProfile==null){
      lsIsThisScreenFromProfile = true;
    }else{
      lsIsThisScreenFromProfile = true;
    }


    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("onTapProfile", lsIsThisScreenFromProfile!);
    print("ONTAP PROFILE ===> " + isThisScreenFromProfile.toString());
    isThisScreenFromProfile =prefs.getBool("onTapProfile")!;

    print("ISSSssss ++++" + isThisScreenFromProfile.toString());
    notifyListeners();
    Get.to(()=>InterSelectionScreen());
  }*/

}
