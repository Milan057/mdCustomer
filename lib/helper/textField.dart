import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:md_customer/helper/colors.dart';

Column getInputFormInputText(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required TextInputType type,
    bool? isPassword,
    String? errorText,
    required FilteringTextInputFormatter inputFormatter}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getErrorText(errorText),
      SizedBox(
        height: 5,
      ),
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 50,
        decoration: BoxDecoration(
            border: getErrorBorder(errorText),
            color: slightScaffoldColor,
            borderRadius: BorderRadius.circular(15)),
        child: TextField(
          obscureText: isPassword ?? false,
          inputFormatters: [inputFormatter],
          keyboardType: type,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: textWhiteColor, fontSize: 18),
          decoration: InputDecoration(
              icon: Icon(
                icon,
                size: 30,
              ),
              iconColor: iconColorCalm,
              hintStyle: TextStyle(color: slightWhiteColor, fontSize: 18),
              hintText: hintText,
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      )
    ],
  );
}

Border getErrorBorder(String? errorText) {
  if (errorText != null) {
    return Border.all(color: Colors.red);
  } else {
    return Border();
  }
}

Widget getErrorText(String? errorText) {
  if (errorText != null) {
    return Row(
      children: [
        Icon(
          Icons.info_rounded,
          color: Colors.red,
          size: 16,
        ),
        SizedBox(
          width: 2,
        ),
        Expanded(
          child: Text(
            overflow: TextOverflow.clip,
            errorText ?? "",
            style: TextStyle(fontSize: 13, color: Colors.red),
          ),
        ),
      ],
    );
  } else {
    return Container(
      height: 16,
    );
  }
}

FilteringTextInputFormatter getTextOnlyFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));
}

FilteringTextInputFormatter getAllCharFormatter() {
  return FilteringTextInputFormatter.allow(RegExp('.'));
}

FilteringTextInputFormatter getDigitOnlyFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}
