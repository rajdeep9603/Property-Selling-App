import 'dart:convert';

import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PhoneCallApi {
  static void callApi(String no1, String no2) async {
    try {
      Loader().showLoader();
      String url = "https://connect.propacy.com/api/uv/calling";
      http.Response response = await http
          .post(Uri.parse(url), body: {"callingFrom": no2, "callingTo": no1});
      print("CallApi Status");
      print(response.statusCode);
      if (response.statusCode == 200) {
        Loader().hideLoader();
        var value = jsonDecode(response.body);
        print(value);
      }
    } catch (e) {
      Loader().hideLoader();
      print(e.toString());
    }
  }
}
