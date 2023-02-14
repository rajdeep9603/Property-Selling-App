import 'dart:convert';

import 'package:com.propacy.b2c/model/chat_model/chat_api_resp_model.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ChatApi {
  static Future<ChatApiResponseModel?> chatApiResp(String propertyId) async {
    try {
      Loader().showLoader();
      String url = "https://connect.propacy.com/api/uv/chatDetails";
      print(url);
      http.Response response =
          await http.post(Uri.parse(url), body: {"propertyId": propertyId});
      print("property");
      print(response.statusCode);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        Loader().hideLoader();
        return chatApiResponseModelFromJson(response.body);
      } else {
        Loader().hideLoader();
        return chatApiResponseModelFromJson(response.body);
      }
    } catch (e) {
      Loader().hideLoader();
      print(e.toString());
    }
  }
}
