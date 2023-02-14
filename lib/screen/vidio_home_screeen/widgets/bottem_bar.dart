import 'package:com.propacy.b2c/screen/vidio_home_screeen/vidio_view_model.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottemBarStopVidio({
  required void Function()? onHomeTap,
  required void Function()? onShortListTap,
  required void Function()? onSettingTap,
  required int indexBottem,
}) {
  return Container(
    width: Get.width,
    height: Get.height / 12,
    color: Colors.black,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Spacer(),
          InkWell(
            onTap: onHomeTap,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: indexBottem == 0
                  ? BoxDecoration(
                      color: ColorRes.divider.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    )
                  : BoxDecoration(),
              child: Image.asset(AssetRes.home, color: Colors.white),
              width: 50,
              height: 40,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: onShortListTap,
            child: Container(
              padding: EdgeInsets.all(7),
              width: 50,
              height: 40,
              decoration: indexBottem == 1
                  ? BoxDecoration(
                      color: ColorRes.divider.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    )
                  : BoxDecoration(),
              child: Image.asset("assets/icons/save.png"),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: onSettingTap,
            child: Container(
              decoration: indexBottem == 2
                  ? BoxDecoration(
                      color: ColorRes.bgColor.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(12),
                    )
                  : BoxDecoration(),
              child: Image.asset(
                AssetRes.settings,
                color: Colors.white,
              ),
              width: 40,
              height: 30,
            ),
          ),
          // Spacer(),
        ],
      ),
    ),
  );
}

// Widget vidioShowBottemBar(VidioViewModel model){
//   return InkWell(
//     onTap: (){
//       model.controller[index].pause();
//       model.notifyListeners();
//       Get.back();
//     },
//     child: Container(
//         width: Get.width,
//         height: Get.height/8.5,
//         color: ColorRes.black,
//         child: Row(
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 15),
//               alignment: Alignment.center,
//               width: Get.width/1.3,
//               height: Get.height/16,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Color(0xFF76CCDD)),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.save_alt,color: Color(0xFF76CCDD)),
//                   SizedBox(width: 10),
//                   Text("Shortlist",style: AppTextStyle(textColor: Color(0xFF76CCDD),size:16,weight: FontWeight.bold),),
//                 ],
//               ),
//             ),
//             Container(
//               child: Image.asset("assets/icons/share.png",color: Colors.white),
//               width: 50,
//               height: 40,
//             ),
//           ],
//         )
//     ),
//   );
// }
