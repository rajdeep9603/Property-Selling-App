import 'package:com.propacy.b2c/screen/splash/splash_screen_view_model.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Stack(
            children: [
              Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image:DecorationImage(
                      image: AssetImage("assets/image/splashimg.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.transparent.withOpacity(0.8), BlendMode.dstATop),
                    )
                  ),
                  // child: Image.asset(
                  //   "assets/image/splashimg.jpg",
                  //   fit: BoxFit.cover,
                  // )
              ),
              Positioned(
                  top: 100,
                  child: Column(
                    children: [
                      Container(
                          height: 70,
                          width: Get.width - 90,
                          margin: EdgeInsets.symmetric(horizontal: 45),
                          child: Image.asset("assets/image/Logo-white.png")),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppRes.splashText,
                        style:
                            AppTextStyle(weight: FontWeight.w600, size: 20),
                      )
                    ],
                  ))
            ],
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
