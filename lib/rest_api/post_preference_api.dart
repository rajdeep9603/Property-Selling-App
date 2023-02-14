import 'dart:convert';
import 'dart:io';

import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/apartment_selection.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/bottom_part.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/professional.dart';
import 'package:com.propacy.b2c/screen/inter_selection/widget/property_range_slider.dart';
import 'package:com.propacy.b2c/screen/search_area/widgets/widgets.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/utils/all_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';

class PostPreferenceApi {
  static Future<PostPreferenceModel?> postPrefenceApi({
    String? userProfile,
    String? intent,
    String? type,
    List<String>? category,
    List<String>? bedRoom,
    String? minPrice,
    String? maxPrice,
    String? customerId,
    String? appCode,
    List<String>? locality,
    List<String>? furnishType,
  }) async {
    try {
      // Loader().showLoader();
      String url = ApiRes.postPreference;
      print(url);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      /* userProfile = isThisScreenFromProfile
          ? userProfileFromTap
          : occupationName ?? "Professional";*/

      userProfile = occupationName ?? "Professional";
      print("USERPROFILE =====>  " + userProfile.toString());
      prefs.setString("userProfile", userProfile.toString());

      // intent = isThisScreenFromProfile ? intentFromTap : radio1 ?? "Buy";
      intent = radio1 ?? "Buy";
      print("INTENT =====>  " + intent.toString());
      prefs.setString("intent", intent.toString());

      /*  type = isThisScreenFromProfile
          ? typeFromTap
          : radioReadytomove ?? "Ready to move";*/
      type = radioReadytomove ?? "Ready to move";
      print("TYPE =====>  " + type.toString());
      prefs.setString("ReadyToMove", type.toString());

      if (displayCat.isNotEmpty) {
        // category = isThisScreenFromProfile ? categoryFromTap : displayCat;
        category = displayCat;
        category.forEach((element) {
          if (categoryMap.containsKey(element) == false) {
            categoryMap.addAll({element: true});
            print("POST CATEGORY CHECK" + categoryMap.toString());
          } else {
            print("NOT CONTAins");
          }
        });
      } else {
        category = ["Apartment"];
      }
      print("CATEGORY POST =====>  " + category.toString());
      prefs.setString("category", category[0].toString());

      // String encodedisplaycat=json.encode(displayCat);
      // print(encodedisplaycat);
      prefs.setStringList("displayCat", displayCat);

      String? encodedMap = json.encode(categoryMap);
      print(encodedMap);
      prefs.setString("postCatMap", encodedMap);
      // area = selectedArea;
      // print("AREA =====>  " + area.toString());
      List<String> selectedData =
          prefs.getStringList("SelectedArea") ?? ["Bandra"];
      if (selectedData.isNotEmpty) {
        locality = selectedData;
      } else {
        locality = ["Borivali", "Bandra"];
      }

      if (locality.length == 1) {
        SharePref.setString("LocMultiple", locality[0]);
      } else {
        SharePref.setString("LocMultiple", "Multiple");
      }
      print("SELECT LOCALITY ====> " + locality.toString());
      prefs.setString("locality", locality[0].toString());
      // prefs.setString("localities", locality.toString());
      // SharePref.setString("localities",  locality.toString());
      String encodeLoc = jsonEncode(locality);
      prefs.setString("localities", encodeLoc);

      if (displayFurnish.isNotEmpty) {
        if (type == "Ready to move") {
          furnishType = displayFurnish;
          furnishType.forEach((element) {
            if (furnishTypesMap.containsKey(element) == false) {
              furnishTypesMap.addAll({element: true});
              print("POST FURNISHTYPE CHECK" + furnishTypesMap.toString());
            } else {
              print("NOT CONTAins");
            }
          });
        } else {
          furnishType = ["None"];
        }
      } else {
        if (type == "Ready to move") {
          furnishType = furnishType2;
        } else {
          furnishType = ["None"];
          print("FURNISH NULL PASS");
        }
      }
      print("SELECT FURNISHTYPE ====> " + furnishType.toString());
      await prefs.setString("furnishType", furnishType[0].toString());
      String? encodedMapFurnish = json.encode(furnishTypesMap);
      print(encodedMapFurnish);
      await prefs.setString("postFurnishMap", encodedMapFurnish);
      //prefs.setString("furnishTypes", furnishType.toString());

      if (displayBedRooms.isNotEmpty) {
        bedRoom = displayBedRooms;
        bedRoom.forEach((element) {
          if (bedRoomMap.containsKey(element) == false) {
            bedRoomMap.addAll({element: true});
            print("POST BEDROOM CHECK" + bedRoomMap.toString());
          } else {
            print("NOT CONTAins");
          }
        });
      } else {
        bedRoom = ["1", "2"];
      }
      print("SELECT BEDROOM ====> " + bedRoom.toString());
      prefs.setString("bedRoom", bedRoom[0].toString());
      if (displayBedRooms.length == 0) {
        List<String> b = ["1"];
        await prefs.setStringList("displayBedRooms", b);
      } else {
        await prefs.setStringList("displayBedRooms", displayBedRooms);
      }

      List<String> getbrd = prefs.getStringList("displayBedRooms")!.toList();
      print(getbrd);

      String? encodedMapBedRoom = json.encode(bedRoomMap);
      print(encodedMapBedRoom);
      prefs.setString("postBedRoomMap", encodedMapBedRoom);
      //prefs.setString("bedRooms", bedRoom.toString());

      // minPrice = isThisScreenFromProfile
      //     ? minPriceFromTap
      //     : selectedMinPrize ?? "80 Lac";
      minPrice = selectedMinPrize ?? "80.0 Lac";
      String minPriceLast = minPrice.substring(minPrice.lastIndexOf(" ") + 1);
      print(minPriceLast);
      if (minPriceLast == "Cr") {
        // min1 = int.parse(minPrice.toString()/*.split(" ").first*/) * 10000000;
        min1 = double.parse(minPrice.toString().split(" ").first) * 10000000;
        print(min1);
      } else if (minPriceLast == "Lac") {
        min1 = double.parse(minPrice.toString().split(" ").first) * 100000;
        print(min1);
      } else if (minPriceLast == "K") {
        min1 = int.parse(minPrice.toString().split(" ").first) * 1000;
        print(min1);
      }
      print("MIN PRICE =====>  " + min1.toString());
      prefs.setString("minPrice", minPrice.toString());

      // maxPrice = isThisScreenFromProfile
      //     ? maxPriceFromTap
      //     : selectedMaxPrize ?? "90 Lac";

      maxPrice = selectedMaxPrize ?? "90.0 Lac";
      String maxPriceLast = maxPrice.substring(maxPrice.lastIndexOf(" ") + 1);
      print(maxPriceLast);
      if (maxPriceLast == "Cr") {
        max1 = double.parse(maxPrice.toString().split(" ").first) * 10000000;
        print(max1);
      } else if (maxPriceLast == "Lac") {
        max1 = double.parse(maxPrice.toString().split(" ").first) * 100000;
        print(max1);
      } else if (maxPriceLast == "K") {
        max1 = int.parse(maxPrice.toString().split(" ").first) * 1000;
        print(max1);
      }
      print("MAX PRICE ====>  " + max1.toString());
      prefs.setString("maxPrice", maxPrice.toString());

      customerId = prefs.getString("loginCustomerId");
      print("LOGIN CUSTOMER ID====>  " + customerId.toString());

      var userId = prefs.getString("userId");
      print("CUSTOMER Firebase UID====>  " + userId.toString());

      Map<String, dynamic> bodyData = firstopenvideo
          ? {
              "customerId": customerId,
            }
          : {
              "userProfile": userProfile,
              "intent": "Buy",
              "type": type,
              "category": category,
              "bedrooms": bedRoom,
              "minPrice": min1 == null ? "8000000" : min1.toString(),
              "maxPrice": max1 == null ? "9000000" : max1.toString(),
              "locality": locality,
              "customerId": customerId,
              "appCode": "connectand",
              "furnishType": furnishType
            };

      print("bodyData1==========>$bodyData");
      print("bodyData2==========>$bodyData");
      print("bodyData3==========>$bodyData");

      var fullBody = json.encode(bodyData);
      http.Response response = await http.post(Uri.parse(url),
          body: fullBody,
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br'
          });

      print(response.body);
      print(response.statusCode);
      print(jsonDecode(response.body));

      // if (jsonDecode(response.body)["arrMatches"]["agent"]["status"] == "Active") {
      if (response.statusCode == 200) {
        // Loader().hideLoader();
        print("true");
        return postPrefenceModelFromJson(response.body);
      } else {
        print("false");
      }
    } catch (e) {
      /*Get.snackbar(
        "noInternet".tr,
        "checkInternet".tr,
        backgroundColor: ColorRes.red,
        colorText: ColorRes.white,
      );*/
      throw Exception(e);
    }
  }

  static Future<bool?> shortlist({
    String? date,
    String? status,
    String? cId,
    String? pId,
    String? command,
  }) async {
    try {
      String url = ApiRes.scheduleAction;
      Map<String, dynamic> bodyData = {
        //"appCode": "propacyAnd",
        "appCode": Platform.isIOS ? "propacyios" : "propacyand",
        "customerId": "$cId",
        "command": command,
        "propertyId": "$pId",
        "dtmSchedule": "$date",
        "status": "$status"
      };

      var fullBody = json.encode(bodyData);

      final response =
          await http.post(Uri.parse(url), body: fullBody, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      print("response.body ${response.body}");

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("true");
        if (result["success"] == "true") {
          return true;
        } else {
          return false;
        }
      } else {
        print("false");
        return false;
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "noInternet".tr,
        "checkInternet".tr,
        backgroundColor: ColorRes.red,
        colorText: ColorRes.white,
      );

      throw Exception(e);
    }
  }
}
