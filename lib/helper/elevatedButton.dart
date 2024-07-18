import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:md_customer/helper/colors.dart';

import 'material_state_color.dart';

Container getBlueElevatedButton(
    {required String text, required Function() onClick, bool? isLoading}) {
  return Container(
    height: 50,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => getColorBlue(states))),
        onPressed: getOnClickOrDisable(isLoading ?? false, onClick),
        child: getTextOrLoading(isLoading: isLoading ?? false, text: text)),
  );
}

Widget getTextOrLoading({required bool isLoading, String? text}) {
  if (!isLoading) {
    return Text(
      text ?? "",
      style: TextStyle(fontSize: 16),
    );
  } else {
    return LoadingAnimationWidget.prograssiveDots(color: whiteColor, size: 35);
  }
}

Function()? getOnClickOrDisable(bool isLoading, Function() onClick) {
  if (isLoading) {
    return null;
  } else {
    return onClick;
  }
}
