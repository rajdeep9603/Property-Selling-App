import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.propacy.b2c/rest_api/background_image_api.dart';
import 'package:com.propacy.b2c/screen/authorization/enter_mobile_screen_view_model.dart';
import 'package:com.propacy.b2c/screen/enter_otp/enter_otp_view_model.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/full_screen_loader.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class EnterOtpScreen extends StatefulWidget {
  final String phone;

  EnterOtpScreen({required this.phone});

  @override
  _EnterOtpScreenState createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
        onModelReady: (model) {
          model.init(widget.phone.toString());
        },
        viewModelBuilder: () => OtpViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: ColorRes.containerbgColor,
            body: WillPopScope(
              onWillPop: willpop,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      // Container(
                      //   width: Get.width,
                      //   height: Get.height/12,
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
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter:
                                    // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 15),
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          )
                        ],
                      ),
                      Container(
                        height: Get.height / 2,
                        decoration: BoxDecoration(
                          color: ColorRes.containerbgColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Text(
                                      AppRes.enterOtp +
                                          "  *" +
                                          '${widget.phone[6]}' +
                                          '${widget.phone[7]}' +
                                          '${widget.phone[8]}' +
                                          '${widget.phone[9]}',
                                      style: AppTextStyle(
                                        size: 16,
                                        weight: FontWeight.w500,
                                        textColor: ColorRes.white,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: ColorRes.darkblue2),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 30),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (model.otp.text
                                                                .length ==
                                                            0 ||
                                                        model.otp.text
                                                                .length <
                                                            6 ||
                                                        model.otp.text
                                                                .length >
                                                            6) {
                                                      model.notValidOtp ==
                                                          true;
                                                      model.openKeyboard =
                                                          false;
                                                      model.notifyListeners();
                                                    } else {
                                                      model.openKeyboard =
                                                          true;
                                                      model.notifyListeners();
                                                    }
                                                    model.notifyListeners();
                                                  },
                                                  style: AppTextStyle(
                                                      textColor:
                                                          ColorRes.white),
                                                  controller: model.otp,
                                                  keyboardType:
                                                      TextInputType.number,

                                                  // autofocus: model.keyboard == true ? true : true,
                                                  autofocus: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          InputBorder.none),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                // color: const Color(0xcffFF8906),
                                                color:
                                                    model.otp.text.length ==
                                                            10
                                                        ? ColorRes.lightblue
                                                        : Colors.transparent,
                                                child: InkWell(
                                                  // onTap: () {
                                                  //   if(model.notValidOtp == true || model.otp.text.length<6 || model.otp.text.length>6){
                                                  //     model.validNotOtp = true;
                                                  //     Get.snackbar("Please Enter valid otp", "Error!",backgroundColor: ColorRes.red.withOpacity(0.4),colorText: ColorRes.white,snackPosition:SnackPosition.BOTTOM,padding: EdgeInsets.all(5));
                                                  //     model.notifyListeners();
                                                  //   }
                                                  //   else{
                                                  //     model.validNotOtp = false;
                                                  //     print(widget.phone);
                                                  //     model.verifyOtp(widget.phone.toString());
                                                  //     model.notifyListeners();
                                                  //   }
                                                  // },

                                                  onTap: () {
                                                    // model.ondirectLogin("6351614948");
                                                    model.notValidOtp = false;
                                                    if (model
                                                            .otp.text.length <
                                                        6) {
                                                      FirebaseAnalyticsService
                                                          .sendAnalyticsEvent1(
                                                              Str.cLogin,
                                                              Str.click,
                                                              Str.lWrong_otp_page);
                                                      Get.snackbar(
                                                          AppRes
                                                              .enterValidOtp,
                                                          AppRes.error,
                                                          backgroundColor:
                                                              ColorRes.red
                                                                  .withOpacity(
                                                                      0.4),
                                                          colorText:
                                                              ColorRes.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5));
                                                      model.notifyListeners();
                                                    } else if (model
                                                            .otp.text.length >
                                                        6) {
                                                      FirebaseAnalyticsService
                                                          .sendAnalyticsEvent1(
                                                              Str.cLogin,
                                                              Str.click,
                                                              Str.lWrong_otp_page);
                                                      Get.snackbar(
                                                          AppRes
                                                              .enterValidOtp,
                                                          AppRes.error,
                                                          backgroundColor:
                                                              ColorRes.red
                                                                  .withOpacity(
                                                                      0.4),
                                                          colorText:
                                                              ColorRes.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5));
                                                      model.notifyListeners();
                                                    } else if (model
                                                            .notValidOtp ==
                                                        true) {
                                                      FirebaseAnalyticsService
                                                          .sendAnalyticsEvent1(
                                                              Str.cLogin,
                                                              Str.click,
                                                              Str.lWrong_otp_page);
                                                      model.notValidOtp =
                                                          false;
                                                      Get.snackbar(
                                                          AppRes
                                                              .enterValidOtp,
                                                          AppRes.error,
                                                          backgroundColor:
                                                              ColorRes.red
                                                                  .withOpacity(
                                                                      0.4),
                                                          colorText:
                                                              ColorRes.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5));
                                                      model.notifyListeners();
                                                    } else {
                                                      //valid otp event
                                                      FirebaseAnalyticsService
                                                          .sendAnalyticsEvent1(
                                                              Str.cLogin,
                                                              Str.click,
                                                              Str.lVerify_otp);
                                                      model.notValidOtp =
                                                          false;
                                                      print(widget.phone);
                                                      model.verifyOtp(widget
                                                          .phone
                                                          .toString());
                                                      Loader().hideLoader();
                                                      model.notifyListeners();
                                                    }
                                                  },

                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 12,
                                                        bottom: 12),
                                                    decoration: model.otp.text
                                                                .length ==
                                                            6
                                                        ? BoxDecoration(
                                                            color: ColorRes
                                                                .lightblue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))
                                                        : BoxDecoration(
                                                            color: Colors
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
                                                        Text(
                                                          AppRes.next,
                                                        ),
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  model.otp.text.length == 0
                                      ? MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom >
                                              0.0
                                          ? Container(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // SizedBox(),
                                                        Text(
                                                          AppRes.didntReceive,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "inter",
                                                              color: ColorRes
                                                                  .darkblue2,
                                                              fontSize: 16),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Get.snackbar(
                                                                AppRes
                                                                    .sendOtp,
                                                                AppRes
                                                                    .pleaseWait,
                                                                backgroundColor:
                                                                    ColorRes
                                                                        .containerbgColor,
                                                                colorText:
                                                                    ColorRes
                                                                        .white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            30),
                                                                snackPosition:
                                                                    SnackPosition
                                                                        .BOTTOM);
                                                            model.otp.clear();
                                                            model.notValidOtp =
                                                                false;
                                                            model.validNotOtp =
                                                                false;
                                                            print(
                                                                widget.phone);
                                                            model.phoneNumberVeryfy(
                                                                widget.phone
                                                                    .toString());
                                                            model
                                                                .notifyListeners();
                                                          },
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .refresh,
                                                                  color: ColorRes
                                                                      .lightblue,
                                                                  size: 25,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10),
                                                                Text(
                                                                  AppRes
                                                                      .resend,
                                                                  style: TextStyle(
                                                                      color: ColorRes
                                                                          .lightblue,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Divider(
                                                      thickness: 2,
                                                      color: ColorRes
                                                          .raioContainer,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                Divider(
                                                  thickness: 2,
                                                  color:
                                                      ColorRes.raioContainer,
                                                ),
                                                SizedBox(
                                                    height: Get.height / 10),
                                                Center(
                                                  child: Text(
                                                    AppRes.didntReceive,
                                                    style: TextStyle(
                                                        fontFamily: "inter",
                                                        color: ColorRes
                                                            .darkblue2,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.snackbar(
                                                        AppRes.sendOtp,
                                                        AppRes.pleaseWait,
                                                        backgroundColor: ColorRes
                                                            .containerbgColor,
                                                        colorText:
                                                            ColorRes.white,
                                                        padding:
                                                            EdgeInsets.all(
                                                                30),
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM);
                                                    model.otp.clear();
                                                    model.notValidOtp = false;
                                                    model.validNotOtp = false;
                                                    print(widget.phone);
                                                    model.phoneNumberVeryfy(
                                                        widget.phone
                                                            .toString());
                                                    model.notifyListeners();
                                                  },
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.refresh,
                                                          color: ColorRes
                                                              .lightblue,
                                                          size: 25,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          AppRes.resend,
                                                          style: TextStyle(
                                                              color: ColorRes
                                                                  .lightblue,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                      : Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // SizedBox(),
                                                    model.notValidOtp == true
                                                        ? Text(
                                                            AppRes.invalidOtp,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "inter",
                                                                color:
                                                                    ColorRes
                                                                        .red,
                                                                fontSize: 12))
                                                        : Text(
                                                            AppRes
                                                                .didntReceive,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "inter",
                                                                color: ColorRes
                                                                    .darkblue2,
                                                                fontSize: 14),
                                                          ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.snackbar(
                                                          AppRes.pleaseWait +
                                                              "!",
                                                          AppRes.sendOtp,
                                                          backgroundColor:
                                                              ColorRes.black,
                                                          colorText:
                                                              ColorRes.white,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  20),
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                          maxWidth: Get.width,
                                                        );
                                                        model.notValidOtp =
                                                            false;
                                                        model.phoneNumberVeryfy(
                                                            widget.phone
                                                                .toString());
                                                        model
                                                            .notifyListeners();
                                                      },
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.refresh,
                                                              color: ColorRes
                                                                  .lightblue,
                                                              size: 25,
                                                            ),
                                                            SizedBox(
                                                                width: 10),
                                                            Text(
                                                              AppRes.resend,
                                                              style: TextStyle(
                                                                  color: ColorRes
                                                                      .lightblue),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Divider(
                                                  thickness: 2,
                                                  color:
                                                      ColorRes.raioContainer,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<bool> willpop() async {
    Get.back();
    return true;
  }
}
