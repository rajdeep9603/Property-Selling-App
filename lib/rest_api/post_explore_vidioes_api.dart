import 'dart:convert';

import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/utils/all_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePostVidioesApi {
  static Future<PostExploreVideoModel?> postExploreApi({
    String? userProfile,
    String? intent,
    String? type,
    List<String>? category,
    List<String>? area,
    String? minPrice,
    String? maxPrice,
    String? customerId,
    String? appCode,
    List<String>? locality,
    List<String>? furnishType,
  }) async {
    try {
      String url = ApiRes.postExloreVidioes;
      print(url);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      customerId = prefs.getString("loginCustomerId");
      print("CUSTOMER ID AT postExloreVidioes ====>  " + customerId.toString());
      prefs.setString("type", type.toString());

      Map<String, dynamic> bodyData = {"customerId": customerId};

      var fullBody = json.encode(bodyData);
      http.Response response =
          await http.post(Uri.parse(url), body: fullBody, headers: {
        'Content-Type': 'application/json',
      });
      print(response.body);
      print(response.statusCode);
      print(jsonDecode(response.body));
      // if (jsonDecode(response.body)["arrMatches"]["agent"]["status"] == "Active") {
      if (response.statusCode == 200) {
        print("true");
        return postExploreVideoModelFromJson(response.body);
      } else {
        print("false");
      }
    } catch (e) {
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
