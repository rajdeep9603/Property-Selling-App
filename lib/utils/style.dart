import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:flutter/material.dart';

TextStyle AppTextStyle(
    {FontWeight? weight,
    double? size,
    Color? textColor,
    TextDecoration? textDecoration,
    double? letterSpacing}) {
  return TextStyle(
    fontFamily: "inter",
    fontWeight: weight ?? FontWeight.normal,
    fontSize: size ?? 16,
    color: textColor ?? ColorRes.white,
    decoration: textDecoration ?? TextDecoration.none,
    letterSpacing: letterSpacing ?? 0,
  );
}
