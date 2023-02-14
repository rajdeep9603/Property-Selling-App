import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Loader {
  showLoader() {
    Get.dialog(
      Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: Get.height,
              width: Get.width,
              color: Colors.transparent,
            ),
            Center(
              child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/image/screenLoader.gif")),
            )
          ],
        ),
      ),
    );
  }

  void hideLoader() {
    Get.back();
  }
}
