import 'package:com.propacy.b2c/utils/asset_res.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  final String image;
  final String name;
  final String lastMsg;
  String? lastMsgTime;
  final bool newMsg;

  UserCard({
    Key? key,
    required this.image,
    required this.name,
    required this.lastMsg,
    this.lastMsgTime,
    required this.newMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    final now = DateTime.now();
    final today = DateTime(now.day, now.month, now.year);
    final yesterday = DateTime(now.day, now.month, now.year - 1);

    if (lastMsgTime != "" && lastMsgTime != null) {
      DateTime date =
          DateFormat('dd/MM/yyyy, kk:mm').parse(lastMsgTime.toString());
      //DateTime d= DateFormat('dd-MM-yyyy hh:mm:ss').parse(date.toString());
      //DateTime check=DateTime.parse(lastMsgTime.toString());

      if (date.month == now.month) {
        if (date.day == now.day) {
          lastMsgTime = "Today";
        } else if (date.day == now.day - 1) {
          lastMsgTime = "Yesterday";
        } else {
          lastMsgTime = date.day.toString() +
              "/" +
              date.month.toString() +
              "/" +
              date.year.toString();
        }
        //lastMsgTime = "Today";
      } else {
        lastMsgTime = date.day.toString() +
            "/" +
            date.month.toString() +
            "/" +
            date.year.toString();
      }
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              image,
              height: 48,
              width: 48,
              errorBuilder: (context, obj, stacktrace) {
                return loadingBuilder();
              },
              loadingBuilder: (context, obj, stacktrace) {
                return loadingBuilder();
              },
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorRes.btnBg,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: newMsg ? ColorRes.btnBg : Colors.transparent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      lastMsg,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorRes.textGrey,
                      ),
                    ),
                    Spacer(),
                    Text(
                      lastMsgTime!,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorRes.textGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingBuilder() {
    return Container(
      height: 48,
      width: 48,
      color: ColorRes.textGrey,
      child: Center(
        child: Image.asset(
          AssetRes.userProfile,
          height: 16,
          width: 14,
        ),
      ),
    );
  }
}
