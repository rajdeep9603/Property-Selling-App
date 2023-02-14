// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/model/get_user_profile_model.dart';
// import 'package:quiz/utils/api_key.dart';
// import 'package:http/http.dart' as http;
// import 'package:quiz/utils/colors.dart';
//
// class FeedPostApi {
//   static feedPostApi({String? token}) async {
//     try {
//       String url = ApiUtils.baseUrl + ApiUtils.profile;
//       Map<String, String> headers = {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
//       http.Response response = await http.get(Uri.parse(url), headers: headers);
//       print(response.body);
//       if (response.statusCode == 200) {
//         print(response.statusCode);
//         print(jsonDecode(response.body));
//         if (jsonDecode(response.body)["success"] == true) {
//           return userProfileModelFromJson(response.body);
//         } else {
//           return null;
//         }
//       } else {
//         return null;
//       }
//     } catch (e) {
//       Get.snackbar(
//         "noInternet".tr,
//         "checkInternet".tr,
//         backgroundColor: ColorRes.red400,
//         icon: Image.asset(
//           "assets/icons/failure_toast.png",
//           height: 25,
//           width: 25,
//         ),
//         colorText: ColorRes.white,
//       );
//       Exception(e);
//     }
//   }
//
//   static Future<UserProfileModel?> getProfileDetail({String? token}) async {
//     try {
//       String url = ApiUtils.baseUrl + ApiUtils.profile;
//       Map<String, String> headers = {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
//       http.Response response = await http.get(Uri.parse(url), headers: headers);
//       print(response.body);
//       if (response.statusCode == 200) {
//         print(response.statusCode);
//         print(jsonDecode(response.body));
//         if (jsonDecode(response.body)["success"] == true) {
//           return userProfileModelFromJson(response.body);
//         } else {
//           return null;
//         }
//       } else {
//         return null;
//       }
//     } catch (e) {
//       Get.snackbar(
//
//         "noInternet".tr,
//         "checkInternet".tr,
//         backgroundColor: ColorRes.red400,
//         icon: Image.asset(
//           "assets/icons/failure_toast.png",
//           height: 25,
//           width: 25,
//         ),
//         colorText: ColorRes.white,
//       );
//       Exception(e);
//     }
//   }
// }
