import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTopBar extends StatelessWidget {
  final VoidCallback onBackBtnTap;
  final String name;
  final VoidCallback callApi;

  const ChatTopBar(
      {Key? key,
      required this.onBackBtnTap,
      required this.name,
      required this.callApi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 25),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetRes.chat,
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorRes.white2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                child: InkWell(
                  onTap: onBackBtnTap,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorRes.white,
                    ), /*Image.asset(
                      AssetRes.backArrow,
                      height: 20,
                      width: 18,
                    )*/
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: InkWell(
                  onTap: callApi,
                  child: Container(
                    padding: EdgeInsets.only(right: 15),
                    height: 20,
                    width: 40,
                    child: Image.asset(
                      "assets/image/call.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 2,
            width: Get.width,
            color: ColorRes.divider,
          ),
        ],
      ),
    );
  }
}
