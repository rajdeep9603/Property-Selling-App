import 'dart:io';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';


class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.containerbgColor,
        body: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    color: ColorRes.containerbgColor,
                    height: 70,
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorRes.textGrey,
                      size: 30,
                    ))),
            Container(
              color: ColorRes.containerbgColor,
              height: Get.height - 70,
              child:InAppWebView(
                  initialUrlRequest:URLRequest(url: Uri.parse("https://kuula.co/share/collection/7kGh3?logo=1&card=1&info=1&logosize=40&fs=1&vr=1&zoom=1&initload=0&thumbs=1")),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
              )
            ),
          ],
        ));
  }
}
/* Scaffold(
      backgroundColor: ColorRes.bgColor,
      body: Container(
        padding: EdgeInsets.all(20),
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
                child: Icon(Icons.arrow_back,color: ColorRes.textGrey,size: 30,)),
            SizedBox(height: 20,),
            Text(" "+AppRes.termsAndConditionTitle,style:AppTextStyle(size: 20,weight: FontWeight.w600,textColor: ColorRes.white2),),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: Get.height-180,
              width: Get.width-40,
              decoration: BoxDecoration(
                border: Border.all(color: ColorRes.white2)
              ),
              child: Text("griufgtojuoitoiyikhyhiky7hu7puoy7p0joupjo"),
            )

          ],
        ),

      ),
    );*/
