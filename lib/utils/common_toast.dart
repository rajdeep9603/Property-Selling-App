import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastDisplay {
  static myToast() {
    return Fluttertoast.showToast(
      msg: "Not Available",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorRes.textGrey,
      textColor: ColorRes.black,
      fontSize: 18,
    );
  }
}
