import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.propacy.b2c/screen/login_successfull_screen/login_sucecessfull_view_model.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class LoginSuccessfully extends StatefulWidget {
  @override
  _LoginSuccessfullyState createState() => _LoginSuccessfullyState();
}

class _LoginSuccessfullyState extends State<LoginSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginSuccessfullViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.containerbgColor,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  // Container(
                  //   width: Get.width,
                  //   height: Get.height/10,
                  //   color: ColorRes.firstBlue,
                  // ),
                  Stack(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height / 2.2,
                        child: CachedNetworkImage(
                          imageUrl:
                              model.element != "" || model.element != null
                                  ? model.element.toString()
                                  : "http://via.placeholder.com/350x150",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                              width: Get.width,
                              height: Get.height / 2.5,
                              child: Image.asset(
                                "assets/image/house.jpg",
                                fit: BoxFit.fill,
                              )),
                          errorWidget: (context, url, error) => Container(
                              width: Get.width,
                              height: Get.height / 2.5,
                              child: Image.asset(
                                "assets/image/house.jpg",
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                            width: Get.width,
                            height: Get.height / 8,
                            child: Image.asset(
                              "assets/image/Shape 3.png",
                              fit: BoxFit.fill,
                            )),
                      )
                    ],
                  ),

                  Container(
                    width: Get.width,
                    height: Get.height / 2,
                    decoration: BoxDecoration(
                      color: ColorRes.containerbgColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              width: 70,
                              height: 70,
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: ColorRes.containerbgColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: ColorRes.white,
                                    size: 50,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                            child: Container(
                                alignment: Alignment.center,
                                width: Get.width - 40,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      AppRes.welcome,
                                      style: TextStyle(
                                          fontFamily: "inter",
                                          color: ColorRes.white,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      AppRes.great,
                                      style: TextStyle(
                                          fontFamily: "inter",
                                          color: ColorRes.white,
                                          fontSize: 18),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginSuccessfullViewModel(),
    );
  }
}
