import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBarArea extends StatelessWidget {
  final VoidCallback onBackBtnTap;

  const TopBarArea({Key? key, required this.onBackBtnTap}) : super(key: key);

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
                    AppRes.chat,
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
                    ),*/
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
