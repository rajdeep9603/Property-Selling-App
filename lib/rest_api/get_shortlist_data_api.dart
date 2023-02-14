import 'dart:convert';

import 'package:com.propacy.b2c/model/get_shortlist_data_model.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/login_successfull_screen/login_successfull.dart';
import 'package:com.propacy.b2c/utils/all_api.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// bool? isLogin=false;
// String? checkUid;
// var checkLoginPreference;
class GetShortListedDataApi {
  static Future<GetShortListDataModel?> getShortListData({String? cId}) async {
    try {
      // Loader().showLoader();
      // String url = ApiRes.getShortList+"appCode=propacyand&customerId=6194f347a54c30d018569bf8&filter=physicaltour";
      // String url = "https://connect.propacy.com/api/uv/scheduleAction?appCode=propacyand&customerId=6194f347a54c30d018569bf8&filter=physicaltour";
      String url =
          "https://connect.propacy.com/api/uv/scheduleAction?appCode=propacyand&customerId=$cId";
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);

      // var bodydata = jsonDecode(response.body)["data"];
      // print(bodydata);
      // bool status = jsonDecodFe(bodydata)["status"];
      if (jsonDecode(response.body)["status"] == "true") {
        // Loader().hideLoader();
        print("success");
        return getShortListDataModelFromJson(response.body);
        // Get.offAll(() => LoginSuccessfully());
      } else {
        print("unsuccessfully");
      }
    } catch (e) {
      print("no data found");
    }
  }
/*  static Future<AreaDetails?> getareaDetail() async {
    try {
      // Loader().showLoader();
      // String url = ApiRes.getShortList+"appCode=propacyand&customerId=6194f347a54c30d018569bf8&filter=physicaltour";
      String url = "https://connect.propacy.com/api/uv/scheduleAction?appCode=propacyand&customerId=6194f347a54c30d018569bf8&filter=physicaltour";
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);

      // var bodydata = jsonDecode(response.body)["data"];
      // print(bodydata);
      // bool status = jsonDecode(bodydata)["status"];
      if(jsonDecode(response.body)["status"] == "true"){
        // Loader().hideLoader();
        print("success");
        List<ArrMatch> arrMatches = jsonDecode(response.body)['data'].map<ArrMatch>((e) => ArrMatch.fromJson(e)).toList();
        return AreaDetails(arrMatches: arrMatches);
        //return areaDetailsFromJson(jsonEncode(jsonDecode(response.body)['data']));
        // Get.offAll(() => LoginSuccessfully());
      }
      else{
        print("unsuccessfully");
      }
    } catch(e){
      print("no data found");
    }
  }*/
}
