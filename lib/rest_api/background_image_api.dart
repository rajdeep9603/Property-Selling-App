import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:com.propacy.b2c/model/get_bg_image_model.dart';
import 'package:com.propacy.b2c/utils/all_api.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:http/http.dart' as http;

T getRandomElement<T>(List<T> list) {
  final random = new Random();
  var i = random.nextInt(list.length);
  return list[i];
}

// class BackgroungImageApi{
//   static bgImageApi()async {
//     try{
//        var url = ApiRes.backgroungImage+"?objectType=onBoarding";
//        print(url);
//        http.Response response  = await http.get(Uri.parse(url));
//        print(response.statusCode);
//
//       // var dataNew = jsonDecode(response.body)["data"];
//       //  print(dataNew);
//       // imageList=jsonDecode(dataNew)["data"]["images"];
//
//       // var dataNew = jsonDecode(response.body)["data"];
//       //  image1 = jsonDecode(dataNew)["data"]["images"][0];
//       //  image2 = jsonDecode(dataNew)["data"]["images"][1];
//       //  image3 = jsonDecode(dataNew)["data"]["images"][2];
//       //  image4 = jsonDecode(dataNew)["data"]["images"][3];
//       //  image5 = jsonDecode(dataNew)["data"]["images"][4];
//       // print(image1);
//       // print(image2);
//       // print(image3);
//       // print(image4);
//       // print(image5);
//
//       // dataNew.forEach((element){
//       //   imageList.add(element);
//       // });
//       imageList=jsonDecode(response.body)["data"]["images"];
//
//       print(getRandomElement(imageList!));
//       // print(jsonDecode(dataNew));
//        if(response.statusCode == 200){
//          print("true");
//           // element = getRandomElement(imageList!);
//           return getRandomElement(imageList!);
//        }
//        else{
//          return null;
//        }
//
//     }
//     catch(e){
//       print(e);
//     }
//   }
// }

class BackgroungImageApi {
  static bgImageApi() async {
    try {
      var url = ApiRes.backgroungImage + "?objectType=onBoarding";
      print(url);
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("true");
        return getBgImageModelFromJson(response.body);
      } else {
        print("NULL");
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
