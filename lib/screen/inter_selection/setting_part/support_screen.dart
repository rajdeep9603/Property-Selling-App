import 'dart:io';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThisWebViewScreen extends StatefulWidget {
  final String? passUrl;

  ThisWebViewScreen({Key? key, required this.passUrl}) : super(key: key);

  @override
  State<ThisWebViewScreen> createState() => _ThisWebViewScreenState();
}

class _ThisWebViewScreenState extends State<ThisWebViewScreen> {
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.load, Str.lWeb_view_page);
    print(widget.passUrl);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.containerbgColor,
        body: Column(
          children: [
            GestureDetector(
                onTap: () {
                  FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.click, Str.lWeb_view_page_back_button);
                  Get.back();
                },
                child: Container(
                    padding: EdgeInsets.only(top: 25, left: 10),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: ColorRes.containerbgColor,
                    height: 80,
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorRes.textGrey,
                      size: 30,
                    ))),
            Stack(
              children: [
                Container(
                  color: ColorRes.containerbgColor,
                  height: Get.height - 80,
                  width: Get.width,
                  // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  child: WebView(
                    initialUrl: widget.passUrl /*AppRes.supportUrl*/,
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                ),
                isLoading
                    ? Container(
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
                            )))
                    : Container(
                        color: ColorRes.containerbgColor,
                      ),
              ],
            ),
          ],
        ));
  }
}
