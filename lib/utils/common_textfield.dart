import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget commonTextFormField({
  double? size,
  String? hintText,
  TextInputType? keyboardType,
  TextEditingController? controller,
  String? Function(String?)? validation,
  InputBorder? border,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool? obscureText,
  TextStyle? hintStyle,
  FocusNode? focusNode,
  InputBorder? inBorder,
  Widget? preicon,
  Color? fillColor,
  void Function(String)? onChangeValue,
}) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    onChanged: onChangeValue,
    focusNode: focusNode,
    controller: controller,
    validator: validation,
    obscureText: obscureText ?? false,
    keyboardType: keyboardType,
    // style: GoogleFonts.poppins(color: isSelectedTheme == "Dark" ? Themes.light : ColorRes.black),
    decoration: InputDecoration(
      filled: true,
      fillColor: fillColor ?? null,
      suffixIcon: suffixIcon,
      prefixIcon: preicon,
      // errorStyle: GoogleFonts.poppins(),
      contentPadding: EdgeInsets.symmetric(vertical: 15),
      hintText: hintText,
      hintStyle: hintStyle ?? null,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      // focusedBorder: borderTextfield(),
      // prefixIcon: prefixIcon,
      // enabledBorder: borderTextfield(),
      // errorBorder: borderTextfield(),
      // disabledBorder: borderTextfield(),
      // focusedErrorBorder: borderTextfield(),
    ),
  );
}

UnderlineInputBorder borderTextfield() {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );
}
