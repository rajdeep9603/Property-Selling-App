import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/screen/authorization/enter_mobile_screen_view_model.dart';
import 'package:com.propacy.b2c/screen/enter_otp/enter_otp_screen.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/common_loader_new.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class EnterMobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EnterMobileScreenViewModel>.reactive(
      onModelReady: (model) async {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.containerbgColor,
          body: model.isBusy
              ? commonLoader()
              : SingleChildScrollView(
                  child: Column(
                    children: [
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
                              // imageUrl:"https://firebasestorage.googleapis.com/v0/b/propacy-develop.appspot.com/o/B2C%2Fonboarding%2Fimages%2FUntitled.jpeg?alt=media&token=c35d1d78-e7f8-4bff-910b-fc2938051eac",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter:
                                    //ColorFilter.mode(Colors.red, BlendMode.colorBurn)
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
                            bottom: -3,
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
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        // height: Get.height /3,
                        decoration: BoxDecoration(
                          color: ColorRes.containerbgColor,
                        ),
                        child: Form(
                          key: model.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppRes.enterMobile,
                                      // model.isOtp == true
                                      //     ? AppRes.enterOtp  +  " *"
                                      //     : AppRes.enterMobile,
                                      style: AppTextStyle(
                                          textColor: ColorRes.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: ColorRes.darkblue2),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 30),
                                                child: TextFormField(
                                                  // validator: (value){
                                                  //   return model.mobileValidation(value);
                                                  // },
                                                  keyboardAppearance: ThemeData
                                                      .estimateBrightnessForColor(
                                                          Colors.black),
                                                  onChanged: (value) {
                                                    // element != "" || element != null ?
                                                    if (model.mobileNumberController
                                                                .text.length >=
                                                            10 &&
                                                        model.mobileNumberController
                                                                .text.length <=
                                                            11) {
                                                      model.isShow = true;
                                                    } else {
                                                      model.isShow = false;
                                                    }
                                                    model.notifyListeners();
                                                  },
                                                  style: AppTextStyle(
                                                      textColor:
                                                          ColorRes.white),
                                                  controller: model
                                                      .mobileNumberController,
                                                  // controller: model.isOtp ==
                                                  //         true
                                                  //     ? model.otpController
                                                  //     : model
                                                  //         .mobileNumberController,
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          signed: false),
                                                  autofocus: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          InputBorder.none),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                // color: const Color(0xcffFF8906),
                                                color:
                                                    model.mobileNumberController
                                                                .text.length ==
                                                            10
                                                        ? ColorRes.lightblue
                                                        : Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    FirebaseAnalyticsService
                                                        .sendAnalyticsEvent1(
                                                            Str.cLogin,
                                                            Str.click,
                                                            Str.lEnter_phoneNumber);
                                                    //is valid number = number not proper by user;
                                                    model.mobileNumberController
                                                                    .text.length <
                                                                9 ||
                                                            model
                                                                    .mobileNumberController
                                                                    .text
                                                                    .length >
                                                                10
                                                        ? model.isValidNumber =
                                                            true
                                                        : model.isValidNumber =
                                                            false;
                                                    model.notifyListeners();
                                                    if (model
                                                        .formKey.currentState!
                                                        .validate()) {
                                                      if (model
                                                              .mobileNumberController
                                                              .text
                                                              .length ==
                                                          10) {
                                                        // Loader().showLoader();
                                                        model.isOtp = true;
                                                        model.isShow = false;
                                                        // getRandomElement(imageList!);
                                                        Get.to(() =>
                                                            EnterOtpScreen(
                                                                phone: model
                                                                    .mobileNumberController
                                                                    .text));
                                                        // Loader().hideLoader();

                                                        model
                                                            .notifyListeners();
                                                        // model.mobileNumberController
                                                        //     .clear();
                                                      } else {
                                                        Get.snackbar(
                                                            AppRes
                                                                .enterValidNumber,
                                                            AppRes.error,
                                                            backgroundColor:
                                                                ColorRes.red
                                                                    .withOpacity(
                                                                        0.4),
                                                            colorText:
                                                                ColorRes
                                                                    .white,
                                                            snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM,
                                                            padding:
                                                                EdgeInsets
                                                                    .all(5));
                                                        model.isOtp = false;
                                                      }
                                                      model.notifyListeners();
                                                    } else {
                                                      Get.snackbar(
                                                          AppRes.fillUpData,
                                                          AppRes.error);
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 12,
                                                        bottom: 12),
                                                    decoration: BoxDecoration(
                                                        color: model
                                                                    .mobileNumberController
                                                                    .text
                                                                    .length ==
                                                                10
                                                            ? ColorRes
                                                                .lightblue
                                                            : Colors
                                                                .transparent,

                                                        // color: model.isShow ==
                                                        //     true
                                                        //     ? ColorRes.lightblue
                                                        //     : Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20)),
                                                    child: Row(
                                                      children: [
                                                        Text(AppRes.next),
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    model.isValidNumber == true
                                        ? Text(
                                            AppRes.enterValidMobileNumber,
                                            style: AppTextStyle(
                                                textColor: ColorRes.red),
                                          )
                                        : SizedBox(),
                                    // model.isOtp == true?Container(
                                    //   child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //   Text(AppRes.didntReceive,style: AppTextStyle(textColor: ColorRes.white),),
                                    //   Row(
                                    //     children: [
                                    //       Icon(Icons.refresh,color: ColorRes.white,size: 25,),
                                    //       SizedBox(width:10),
                                    //       Text(AppRes.resend,style: AppTextStyle(textColor: ColorRes.white),),
                                    //     ],
                                    //   ),
                                    //
                                    // ],),):Container()
                                  ],
                                ),
                              ),
                              Divider(
                                color: ColorRes.raioContainer,
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
      viewModelBuilder: () => EnterMobileScreenViewModel(),
    );
  }
}
