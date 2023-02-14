import 'dart:convert';

import 'package:com.propacy.b2c/model/login_api_model.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/login_successfull_screen/login_successfull.dart';
import 'package:com.propacy.b2c/services/chat_service/chat_service.dart';
import 'package:com.propacy.b2c/utils/all_api.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// bool? isLogin=false;

class LoginApi {
  static Future<LoginModel?> loginApi({
    String? verificationToken,
    String? appCode,
    String? phoneNumber,
    String? userAgent,
    String? osVersion,
    String? deviceToken,
    String? currentUserUid,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Loader().showLoader();
      String url = ApiRes.baseurl +
          "verificationToken=$verificationToken" +
          "&appCode=$appCode" +
          "&phoneNumber=$phoneNumber" +
          "&osVersion=$osVersion" +
          "&deviceToken=$deviceToken" +
          "&currentUserUid=$currentUserUid";
      //   String url =ApiRes.baseurl+
      //       "verificationToken=eyJhbGciOiJSUzI1NiIsImtpZCI6IjgwNTg1Zjk5MjExMmZmODgxMTEzOTlhMzY5NzU2MTc1YWExYjRjZjkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcHJvcGFjeS1kZXZlbG9wIiwiYXVkIjoicHJvcGFjeS1kZXZlbG9wIiwiYXV0aF90aW1lIjoxNjM4MzUwMDMxLCJ1c2VyX2lkIjoiUXp6RHVWdU1WOWJMZk9ENVhBZnJlWVhHb0xwMiIsInN1YiI6IlF6ekR1VnVNVjliTGZPRDVYQWZyZVlYR29McDIiLCJpYXQiOjE2MzgzNTAwMzEsImV4cCI6MTYzODM1MzYzMSwicGhvbmVfbnVtYmVyIjoiKzkxNjM1MTYxNDk0OCIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsicGhvbmUiOlsiKzkxNjM1MTYxNDk0OCJdfSwic2lnbl9pbl9wcm92aWRlciI6InBob25lIn19.nZgn6BZTC9sRYAJMUjJKyE81MEtH3Fv835pc-1NAs0-WP0dSjyGoabw_EVTx5lUCC8tE0eEzG8BeHb8N7tk4K_aqwBUGGbM59qYZchTNigLGd2e9ZN1oyoyH1PSawkg8KlReVE9_0kf-atVmMpPg9DPvPBuE8yI4OFYBOzU0ANxgH2I7rX0pZRM70ld7CkVpU-fscCMFXpoIVjFf3OSIAd9c5-EyWbfWTw1Qi4ES87In7b15TbHwFd8pLg9YaghlCzMfxxbixO-1Zog9V-juM1l9oSer1EJyjv57oUSiAaHi1wiMG7c4vdkVM-g6PRhouJNDxVMKZ91P81uXaTtTuw"
      //       + "&appCode=propacyand"
      //       + "&phoneNumber=6351614948"
      //       + "&osVersion=android"
      //       +"&deviceToken=d5T8r5_rQvWvvxHwhUJ0UK:APA91bGSG-WytLX5zivKX-vaazCa-4IAa_4NpKm7UEMTmbTuOtrc1M92sG8g9-54nIzyISSABpl2Obhbax49KUbRCjuemfaDGjlVvuZLlpiFlNfjJ5DDJwtjX23zZRcCNXyhXhYKmTME"
      //       +"&currentUserUid=QzzDuVuMV9bLfOD5XAfreYXGoLp2";
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);

      print("verificationToken : $verificationToken");
      print("appCode : $appCode");
      print("phoneNumber : $phoneNumber");
      prefs.setString("userMobile", phoneNumber!);
       await ChatService.setUser(deviceToken.toString());
      print("userAgent : $userAgent");
      print("osVersion : $osVersion");
      print("deviceToken : $deviceToken");
      prefs.setString("deviceToken", deviceToken!);
      print("currentUserUid : $currentUserUid");
      if (response.statusCode == 200) {
        print("true");
        return loginModelFromJson(response.body);
      } else {
        print("false");
      }
    } catch (e) {
      print(e.toString());
      print("no data found");
    }
  }
}
