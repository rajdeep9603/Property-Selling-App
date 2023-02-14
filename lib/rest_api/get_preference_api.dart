import 'dart:convert';

import 'package:com.propacy.b2c/model/get_preference_model.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/screen/login_successfull_screen/login_successfull.dart';
import 'package:com.propacy.b2c/utils/all_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetPreference {
  static Future<GetPreferenceModel?> getPreference() async {
    try {
      String? url = ApiRes.basePref + "objectType=preferences";
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      // var bodydata = jsonDecode(response.body)["data"];
      // print(bodydata);
      // print(jsonDecode(bodydata));
      // bool status = jsonDecode(bodydata)["status"];
      if (jsonDecode(response.body)["status"] == "true") {
        print("success get preference");
        return getPreferenceModelFromJson(response.body);

        //  model!.occupation1 = jsonDecode(bodydata)["data"]["occupation"];
        //  // list = jsonDecode(bodydata)["data"]["occupation"];
        //  model.bedrooms = jsonDecode(bodydata)["data"]["bedrooms"];
        // model.intent = jsonDecode(bodydata)["data"]["intent"];
        //  model.type = jsonDecode(bodydata)["data"]["type"];
        //  model.category = jsonDecode(bodydata)["data"]["category"];
        //  model.lookingTo  = jsonDecode(bodydata)["data"]["lookingTo"];
        //  model.lookingFor = jsonDecode(bodydata)["data"]["lookingFor"];
        //  model.notifyListeners();

      } else {
        print("unsuccessfully");
      }
    } catch (e) {
      print("no data found");
    }
  }
}
