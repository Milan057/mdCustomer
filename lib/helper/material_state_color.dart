import 'package:flutter/material.dart';
import 'package:md_customer/helper/colors.dart';

Color getColorBlue(Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return slightThemeColor;
  }
  return themeColor; // Default color
}

Color getColorWhite(Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return slightWhiteColor;
  }
  return whiteColor; // Default color
}
