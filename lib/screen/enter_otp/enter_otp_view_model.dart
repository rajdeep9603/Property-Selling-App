import 'dart:convert';

import 'package:com.propacy.b2c/model/get_bg_image_model.dart';
import 'package:com.propacy.b2c/model/login_api_model.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/rest_api/login_api.dart';
import 'package:com.propacy.b2c/screen/authorization/enter_mobile_screen_view_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/screen/login_successfull_screen/login_successfull.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class OtpViewModel extends BaseViewModel {
  // var element = getRandomElement(imageList!);
  LoginModel loginNewModel = LoginModel();
  GetBgImageModel bgModel = GetBgImageModel();
  TextEditingController otp = TextEditingController();
  String? verificationCode;
  bool? notValidOtp = false;
  bool? openKeyboard = true;
  bool? checkOtp = false;
  String? uid;
  String? userID;
  String? deviceToken;
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? result;
  bool? validNotOtp;
  String? uIdToken;
  bool? keyboard = true;
  String? element;
  String? min;
  String? max;

  init(phone) {
    FirebaseAnalyticsService.sendAnalyticsEvent1(
        Str.cLogin, Str.load, Str.lOtp_fill_page);
    keyboard = true;
    phoneNumberVeryfy(phone);
    getCurrentDeviceToken();
    // getRandomElement(imageList!);
    getBgImage();
    // refreshFirebaseUser();
  }

  // Future<void>getBgImage() async {
  //   String? image = await BackgroungImageApi.bgImageApi();
  //   element = image;
  //   notifyListeners();
  // }

  Future<void> getBgImage() async {
    element = getRandomElement(bgImages);
  }

  // Future refreshFirebaseUser() async {
  //   if (auth.currentUser != null) {
  //     final user = auth.currentUser;
  //     await user!.getIdTokenResult(true).then((value)async{
  //     // IdTokenResult idTokenResult = await user!.getIdTokenResult(true).then((value)async{
  //       uIdToken =  value.token.toString();
  //       notifyListeners();
  //     });
  //     // return idTokenResult;
  //   }
  // }

  getIdTokenFromFirebase() async {
    uIdToken = await auth.currentUser!.getIdToken();
    print(uIdToken);
    notifyListeners();
  }

  getCurrentUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = await prefs.getString("userId");
    print(userID);
    notifyListeners();
  }

  getCurrentDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    deviceToken = await prefs.getString("deviceToken");
    print(deviceToken);
    notifyListeners();
  }

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
          keyboard = true;
          if (value.user!.uid != null) {
            uid = value.user!.uid.toString();
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString("userId", uid!);
            print(uid);
            print(value);
            print("value : $value");
            print("success");
            notifyListeners();
            otp.clear();
            // Get.to(()=>LoginSuccessfully());
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.toString());
        notValidOtp = true;
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

  verifyOtp(String phone) async {
    try {
      Loader().showLoader();
      notValidOtp = false;
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode!, smsCode: otp.text))
          .then((value) async {
        // await getCurrentDeviceToken();
        Loader().hideLoader();
        print(value);
        if (value.user != null) {
          uid = value.user!.uid.toString();
          // uIdToken = value.user!.getIdToken().toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          prefs.setString("userId", value.user!.uid);
          // prefs.setBool("isUserId",true);
          print(uid);
          notifyListeners();
          await getIdTokenFromFirebase();
          await getCurrentUid();
          print(uIdToken);
         await onNextLogin(phone);

          // Get.off(() => LoginSuccessfully());
        } else {
          checkOtp = true;
          notValidOtp = true;
          print("invalid otp");
          notifyListeners();
        }
      });
    } catch (e) {
      checkOtp = true;
      notValidOtp = true;
      print("invalid otp");
      notifyListeners();
      throw Exception(e);
    }
  }

  onNextLogin(String phone) async {
    await getCurrentUid();
    LoginApi.loginApi(
      phoneNumber: phone,
      currentUserUid: uid,
      deviceToken: deviceToken,
      osVersion: "android",
      appCode: "propacyand",
      userAgent: "userAgent",
      verificationToken: uIdToken,
    ).then((value) async {
      loginNewModel = value!;
      notifyListeners();

      if (loginNewModel.status == "true") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // SharePref.getBool("isLogin",true);
        prefs.setBool("isLogin", true);
        Loader().hideLoader();

        //var logCustomerId = jsonDecode(response.body)["data"]["customerId"]["\$oid"];
        logCustomerId = loginNewModel.data!.customerId!.oid;
        print(logCustomerId);
        prefs.setString("loginCustomerId", logCustomerId!);

        if (loginNewModel.data!.preferences!.length > 0) {
          loginHasPref = true;
          loginArea = true;
          isProceedTap = true;
          prefs.setBool("isProceedTap", isProceedTap);
          notifyListeners();
          print(isProceedTap);

          loginLocalityList = loginNewModel.data!.preferences![0].subCity;
          print(loginLocalityList);
          if (loginLocalityList!.length == 1) {
            prefs.setStringList("SelectedArea", loginLocalityList);
            SharePref.setString("LocMultiple", loginLocalityList[0]);
            locOnTap = loginLocalityList[0];
            ab2 = loginLocalityList;
            // loginLocality = [];
          } else if (loginLocalityList!.length > 1) {
            locOnTap = "Multiple";
            SharePref.setString("LocMultiple", "Multiple");
            loginLocality = "Multiple";
            ab2 = loginLocalityList;
          } else {
            locOnTap = "Select";
          }

          // prefs.setString("loginLocality1", loginLocality.toString());

          String encodeLocLogin = jsonEncode(loginLocalityList);
          SharePref.setString("LocalityList", encodeLocLogin);

          // loginOccupation = loginNewModel.data!.preferences![0].occupation;
          // print(loginOccupation);
          // prefs.setString("LoginOccupation", loginOccupation.toString());

          ///occupation done
          occupationName = loginNewModel.data!.preferences![0].occupation;
          print(occupationName);
          // prefs.setString("LoginOccupation", occupationName.toString());

          // loginCategory = loginNewModel.data!.preferences![0].category![0];
          // print(loginCategory);
          selectedApartment = loginNewModel.data!.preferences![0].category![0];
          print(selectedApartment);
          loginNewModel.data!.preferences![0].category!.forEach((ele) {
            if (categoryMap.containsKey(ele) == false) {
              categoryMap.addAll({ele: true});
              displayCat.add(ele);
            }
          });
          String? encodedMap = json.encode(categoryMap);
          print(encodedMap);
          prefs.setString("postCatMap", encodedMap);
          print("LOGIN CATEGORY" + categoryMap.toString());
          prefs.setString("loginLocality", loginCategory.toString());


          radio1 = loginNewModel.data!.preferences![0].propType;
          print(radio1);


          radioReadytomove =
          loginNewModel.data!.preferences![0].constructionType;
      print(radioReadytomove);


          selectedbhk = loginNewModel.data!.preferences![0].bedrooms![0];
          print(selectedbhk);
          loginNewModel.data!.preferences![0].bedrooms!.forEach((element) {
            if (bedRoomMap.containsKey(element) == false) {
              bedRoomMap.addAll({element: true});
              displayBedRooms.add(element);
            }
          });
          String? encodedMapBedRoom = json.encode(bedRoomMap);
          print(encodedMapBedRoom);
          prefs.setString("postBedRoomMap", encodedMapBedRoom);


          loginNewModel.data!.preferences![0].furnishType!.forEach((element) {
            if (furnishTypesMap.containsKey(element) == false) {
              furnishTypesMap.addAll({element: true});
              displayFurnish.add(element);
            }
          });
          print(displayFurnish);
          String? encodedMapFurnish = json.encode(furnishTypesMap);
          print(encodedMapFurnish);
          await prefs.setString("postFurnishMap", encodedMapFurnish);

          loginMinPrice = loginNewModel.data!.preferences![0].minPrice;
          int loginMin =
              int.parse(loginMinPrice.toString().split(".").first.toString());
          String? rangeLoginMin;
          if (loginMin >= 10000000) {
            double d = loginMin / 10000000;
            rangeLoginMin = d.toString()/*.split(".").first.toString()*/ + " Cr";
          } else if (loginMin >= 100000) {
            double d = loginMin / 100000;
            rangeLoginMin = d.toString()/*.split(".").first.toString()*/ + " Lac";
          } else if (loginMin >= 1000) {
            double d = loginMin / 1000;
            rangeLoginMin = d.toString().split(".").first.toString() + " K";
          }
          print("rangeLoginMin" + rangeLoginMin.toString());
          prefs.setString("minPrice", rangeLoginMin.toString());

          loginMaxPrice = loginNewModel.data!.preferences![0].maxPrice;
          int loginMax =
              int.parse(loginMaxPrice.toString().split(".").first.toString());
          String? rangeLoginMax;
          if (loginMax >= 10000000) {
            double d = loginMax / 10000000;
            rangeLoginMax = d.toString()/*.split(".").first.toString()*/ + " Cr";
          } else if (loginMax >= 100000) {
            double d = loginMax / 100000;
            rangeLoginMax = d.toString()/*.split(".").first.toString()*/ + " Lac";
          } else if (loginMax >= 1000) {
            double d = loginMax / 1000;
            rangeLoginMax = d.toString().split(".").first.toString() + " K";
          }
          print("rangeLoginMax " + rangeLoginMax.toString());
          prefs.setString("maxPrice", rangeLoginMax.toString());

          int logmin =
              int.parse(loginMinPrice.toString().split(".").first.toString());
          int logmax =
              int.parse(loginMaxPrice.toString().split(".").first.toString());
          if (logmin >= 10000000) {
            double d = logmin / 10000000;
            min = d.toString()/*.split(".").first.toString()*/ + "Cr";
          } else if (logmin >= 100000) {
            double d = logmin / 100000;
            min = d.toString()/*.split(".").first.toString()*/ + " Lac";
          } else if (logmin >= 1000) {
            double d = logmin / 1000;
            min = d.toString().split(".").first.toString() + " K";
          }

          if (logmax >= 10000000) {
            double d = logmax / 10000000;
            max = d.toString()/*.split(".").first.toString()*/ + " Cr";
          } else if (logmax >= 100000) {
            double d = logmax / 100000;
            max = d.toString().split(".").first.toString() + " Lac";
          } else if (logmax >= 1000) {
            double d = logmax / 1000;
            max = d.toString().split(".").first.toString() + " K";
          }

          range3 = "$min - $max";
          print("$min - $max");
          print("LOGIN RANGE FROM PREFERENCES : " + range3);
          print("DATA WHEN LOGIN PREFERENCES NOT NULL ::: $occupationName , $selectedbhk , $radio1, $range3,  $radioReadytomove  , $selectedApartment, $displayBedRooms,   $displayCat , $categoryMap , $bedRoomMap");

        }
        else {
          print("NOT DATA OF LOGIN ======  ");
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString("userProfile", "Professional");
          occupationName = "Professional";
          selectedbhk = "2";
          radio1 = "Buy";
          range3 = "80.0 Lac - 90.0 Lac";
          radioReadytomove="Ready to move";
          selectedApartment = "Apartment";
          var bhk = ["1", "2"];
          // Future.delayed(Duration(milliseconds: 500),(){
            bhk.forEach((element) {
              if (bedRoomMap.containsKey(element) == false) {
                bedRoomMap.addAll({element: true});
                displayBedRooms.add(element);
              }
            });
            String? encodedMapBedRoom = json.encode(bedRoomMap);
            print(encodedMapBedRoom);
            prefs.setString("postBedRoomMap", encodedMapBedRoom);
          // });


           print(displayBedRooms);
          var apart = ["Apartment"];
           // Future.delayed(Duration(milliseconds: 500),(){
             apart.forEach((ele) {
               if (categoryMap.containsKey(ele) == false) {
                 categoryMap.addAll({ele: true});
                 displayCat.add(ele);
               }
             });
             String? encodedMap = json.encode(categoryMap);
             print(encodedMap);
             prefs.setString("postCatMap", encodedMap);
           // });



           var furnish=["Full","Semi"];
          // Future.delayed(Duration(milliseconds: 500),(){
            furnish.forEach((ele) {
              if (furnishTypesMap.containsKey(ele) == false) {
                furnishTypesMap.addAll({ele: true});
                displayFurnish.add(ele);
              }
            });
            String? encodedMapFurnish = json.encode(furnishTypesMap);
            print(encodedMapFurnish);
            prefs.setString("postFurnishMap", encodedMapFurnish);

            print("-----$furnishTypesMap, ---$displayFurnish");
          // });


        print("DATA WHEN LOGIN PREFERENCES NULL ::: $occupationName , $selectedbhk , $radio1, $range3,  $radioReadytomove  , $selectedApartment, $displayBedRooms,   $displayCat , $categoryMap , $bedRoomMap");

        }
        print("success");

        Get.offAll(() => LoginSuccessfully());
      }
    });
  }

}
