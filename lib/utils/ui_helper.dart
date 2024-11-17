
import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle mTextStyle20(
    {FontWeight mFontWeight = FontWeight.bold,
      Color mFontColor = Colors.black}) {
  return TextStyle(fontSize: 20, fontWeight: mFontWeight, color: mFontColor);
}

TextStyle mTextStyle16(
    {FontWeight mFontWeight = FontWeight.bold,
      Color mFontColor = Colors.black}) {
  return TextStyle(fontSize: 16, fontWeight: mFontWeight, color: mFontColor);
}

TextStyle mTextStyle13(
    {FontWeight mFontWeigh = FontWeight.bold,
      Color mFontColor = Colors.black}) {
  return TextStyle(fontSize: 13, fontWeight: mFontWeigh, color: mFontColor);
}
TextStyle mTextStyle10(
    {FontWeight mFontWeigh = FontWeight.bold,
      Color mFontColor = Colors.black}) {
  return TextStyle(fontSize: 10, fontWeight: mFontWeigh, color: mFontColor);
}

TextStyle mTextStyle15(
    {FontWeight mFontWeigh = FontWeight.bold,
      Color mFontColor = Colors.black}) {
  return TextStyle(fontSize: 15, fontWeight: mFontWeigh, color: mFontColor);
}



/// coustom

class DecorationUtils{
  static InputDecoration mTextField({double mBorderRadius=11,Color mColor=Colors.black,required String hintText,required String label})=>InputDecoration(
    hintText: hintText,
    labelText: label,
    enabledBorder: OutlineInputBorder(
      borderRadius:BorderRadius.circular(mBorderRadius),
      borderSide: BorderSide(color: mColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(mBorderRadius),
      borderSide: BorderSide(color: mColor),
    )
  );
}

class SizedBoxUtil{
  static SizedBox mSizedBox({double mWidth=11,double mHeight=11})=>SizedBox(
    width:mWidth,
    height: mHeight
  );
}
