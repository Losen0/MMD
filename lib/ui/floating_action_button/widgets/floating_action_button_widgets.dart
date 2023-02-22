import 'package:flutter/material.dart';
import 'package:todo_app/models/localizatoin_model/localization.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/color_resources.dart';

class FloatingActionButtonWidgets {
  ///Used for all Texts in this page , require --> String , boolean for alignment or not
  /// and optional textStyle or use the one in it
  static Widget text(String txt, bool translate, [TextStyle? textStyle]) {
    return Builder(builder: (context) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.num3),
          child: Text(
            translate
                ? AppLocalization.of(context).getTranslatedValues(txt)
                : txt,
            style: textStyle ?? Theme.of(context).textTheme.labelLarge,
          ),
        ),
      );
    });
  }

  ///this is the decoration for the TextFormFields
  static InputDecoration inputDecorationForTextFormFields(
      String hintTxt, TextStyle? textStyle) {
    return InputDecoration(
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.secondary),
        borderRadius: BorderRadius.circular(AppSizes.num5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: ColorManager.secondary, width: AppSizes.num3),
        borderRadius: BorderRadius.circular(AppSizes.num5),
      ),
      errorStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      hintText: hintTxt,
      hintStyle: textStyle,
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.num5)),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: ColorManager.secondary, width: AppSizes.num3),
        borderRadius: BorderRadius.circular(AppSizes.num5),
      ),
    );
  }
}
