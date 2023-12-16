import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const kPrimaryColor = Color(0xffde0a1e);
  static const kAccentColor = Color(0XFFFF4701);
  static const kErrorColor = Color(0XFFE61F34);
  static const kSuccessColor = Colors.green;
  static const kBlackColor = Color(0XFF000000);
  static const kWhiteColor = Color(0XFFFFFFFF);
  static const kGrey = Colors.grey;
  static const kTextField = Color(0xFFF5F5F5);

  // padding
  static const kHorizontalPadding = 20.0;
}

class OnboardingData {
  final String imagePath;
  final Text headline;
  final Text description;

  OnboardingData(
      {required this.imagePath,
      required this.headline,
      required this.description});
}
