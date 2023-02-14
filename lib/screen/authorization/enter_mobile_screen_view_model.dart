import 'package:com.propacy.b2c/model/get_bg_image_model.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class EnterMobileScreenViewModel extends BaseViewModel {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isShow = false;
  bool isOtp = false;
  bool isValidNumber = false;
  String? token;
  String? uid;
  String? element;

  String? verificationCode;
  GetBgImageModel bgModel = GetBgImageModel();

  phoneNumberVeryfy(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // var user = FirebaseAuth.instance.currentUser;
        // final uid = user!.uid;
        // print(uid);
        print(credential);

        // await FirebaseAuth.instance
        //     .signInWithCredential(credential)
        //     .then((AuthResult authRes) {
        //   firebaseUser = authRes.user;
        //   print(_firebaseUser.toString());
        // });

        await FirebaseAuth.instance.signInWithCredential(credential)
            // print(result!.user!.uid);
            .then((value) async {
          if (value.user!.uid != null) {
            uid = value.user!.uid.toString();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("userId", uid!);
            print(uid);
            print(value);
            print("value : $value");
            print("success");
            notifyListeners();
            // otp.clear();
            // Get.to(()=>LoginSuccessfully());
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        // notValidOtp = true;
        print("invalid otp");
        notifyListeners();
      },
      codeSent: (String vId, int? recentToken) {
        verificationCode = vId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String vID) {
        verificationCode = vID;
        notifyListeners();
      },
      timeout: Duration(seconds: 60),
    );
  }

  // var element = getRandomElement(imageList!);
  void init() async {
    FirebaseAnalyticsService.sendAnalyticsEvent1(
        Str.cLogin, Str.load, Str.lEnter_phoneNumber_Page);
    getBgImage();
    getDevicetoken();
  }

  getDevicetoken() async {
    token = await FirebaseMessaging.instance.getToken();
    print(token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("deviceToken", token!);
    notifyListeners();
  }

  //  Future<void>getBgImage() async {
  //   String? image = await BackgroungImageApi.bgImageApi();
  //   element = image;
  //   notifyListeners();
  // }

  Future<void> getBgImage() async {
    setBusy(true);
    await BackgroungImageApi.bgImageApi().then((val) {
      setBusy(false);
      bgModel = val;
      print(bgModel.toString());
      bgImages = bgModel.data!.images!;
      element = getRandomElement(bgImages);
      print(getRandomElement(bgImages));
      // print("===images===>  "+element.toString());
      notifyListeners();
    });
  }

  void showConainer() {
    if (mobileNumberController.text.length >= 10) {
      isShow = true;
    } else {
      isShow = false;
    }
    notifyListeners();
  }

  String? mobileValidation(value) {
    if (value == null || value == '') {
      return AppRes.pleaseEnterValidMobileNumber;
    } else if (value.length < 10) {
      return AppRes.enterValidNumber;
    } else {
      return null;
    }
  }
}
