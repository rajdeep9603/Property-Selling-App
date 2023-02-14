import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class VrUrlViewScreen extends StatefulWidget {
  final String? passUrl;
  final String? propertyId;

  VrUrlViewScreen({Key? key, required this.passUrl,required this.propertyId}) : super(key: key);

  @override
  State<VrUrlViewScreen> createState() => _VrUrlViewScreen();
}

class _VrUrlViewScreen extends State<VrUrlViewScreen> {
  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  bool isLoading = true;
  final _key = UniqueKey();
@override
  void initState() {
  FirebaseAnalyticsService.sendAnalyticsEvent3(
      Str.cFeeds, Str.load, Str.l360_view_page,widget.propertyId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.containerbgColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    FirebaseAnalyticsService.sendAnalyticsEvent3(
                        Str.cFeeds, Str.load, Str.l360_view_page_back_button,widget.propertyId);
                    Get.back();
                  },
                  child: Container(
                      padding: EdgeInsets.only( left: 10,),
                      alignment: Alignment.centerLeft,
                      width: Get.width,
                      color: ColorRes.containerbgColor,
                      height: 80,
                      child: Column(
                        children: [
                          SizedBox(height: 35,),
                          Icon(
                            Icons.arrow_back,
                            color: ColorRes.textGrey,
                            size: 30,
                          ),
                        ],
                      ))),
              Stack(
                children: [
                  Container(
                      color: ColorRes.containerbgColor,
                      height: Get.height - 80,
                      child: InAppWebView(
                        key: _key,
                        initialUrlRequest:
                            URLRequest(url: Uri.parse(widget.passUrl.toString())),
                        onWebViewCreated: (InAppWebViewController controller) {
                          _webViewController = controller;
                        },
                        onLoadStart: (InAppWebViewController controller, url) {
                          setState(() {
                            this.url = url as String;
                          });
                        },
                        onProgressChanged:
                            (InAppWebViewController controller, int progress) {
                          setState(() {
                            this.progress = progress / 100;
                          });
                        },
                        onLoadStop: (InAppWebViewController controller, url) {
                          setState(() {
                            this.progress = 0;
                            isLoading=false;
                          });
                        },
                      )),
                  isLoading ?  Container(
                      height: Get.height - 80,
                      color: ColorRes.containerbgColor,
                      alignment: FractionalOffset.topCenter,
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                      "assets/image/screenLoader.gif")),
                              SizedBox(height: 80,)
                            ],
                          ))) : SizedBox()
                ],
              ),
            ],
          ),
        ));
  }
}
