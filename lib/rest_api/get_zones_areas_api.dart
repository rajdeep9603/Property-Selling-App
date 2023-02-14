import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/utils/all_api.dart';
import 'package:http/http.dart' as http;

class GetZonesApi {
  static Future<GetZonesModel?> getZones() async {
    try {
      var url = ApiRes.getZones;
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      print(response.statusCode);
      if (jsonDecode(response.body)["status"].toString() == "true") {
        print("success get zones");
        return getZonesModelFromJson(response.body);
      } else {
        return null;
        print("error callimg here");
      }
    } catch (e) {
      print(e);
    }
  }
}
