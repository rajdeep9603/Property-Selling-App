import 'package:com.propacy.b2c/screen/vidio_home_screeen/vidio_view_model.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget shortlistBottemBar({
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


// import 'package:com.propacy.b2c/utils/color_res.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// Widget shortlistBottemBar({
//   required void Function()? onHomeTap,
//   required void Function()? onShortListTap,
//   required void Function()? onSettingTap,
//   required int indexBottem,
// }) {
//   return Container(
//     height: Get.height / 12,
//     width: Get.width,
//     color: ColorRes.black,
//     child: Padding(
//       // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//       // padding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           // Spacer(),
//           InkWell(
//             onTap: onHomeTap,
//             child: Stack(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 30,
//                   decoration: indexBottem == 0
//                       ? BoxDecoration(
//                           color: ColorRes.divider.withOpacity(0.5),
//                           borderRadius: BorderRadius.circular(12),
//                         )
//                       : BoxDecoration(),
//                   child: Image.asset("assets/icons/home.png"),
//                 ),
//                 /*  Positioned(
//                   top: 7,
//                   right: 8,
//                   child:Container(
//                     width: 10,
//                   height: 20,
//                   child: Image.asset("assets/icons/circle.png"),
//                 ),)*/
//               ],
//             ),
//           ),
//           Spacer(),
//           InkWell(
//             onTap: onShortListTap,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               width: 50,
//               height: 40,
//               decoration: indexBottem == 1
//                   ? BoxDecoration(
//                       color: ColorRes.divider.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(12),
//                     )
//                   : BoxDecoration(),
//               child: Image.asset("assets/icons/save.png"),
//             ),
//           ),
//           Spacer(),
//           InkWell(
//             onTap: onSettingTap,
//             child: Container(
//               width: 40,
//               height: 30,
//               decoration: indexBottem == 2
//                   ? BoxDecoration(
//                       color: ColorRes.divider.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(12),
//                     )
//                   : BoxDecoration(),
//               child: Image.asset("assets/icons/setting.png"),
//             ),
//           ),
//           // Spacer(),
//         ],
//       ),
//     ),
//   );
// }
