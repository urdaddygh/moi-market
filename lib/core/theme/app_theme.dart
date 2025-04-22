
import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

final lightTheme = ThemeData(
  fontFamily: 'Roboto',
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //   unselectedLabelStyle: Style.bottomNavigatorText,
  // ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: Style.smallSpacing, horizontal: Style.defaultSpacing),
    filled: true,
    fillColor: Colors.white,
    // constraints: const BoxConstraints(minHeight: Style.inputHeight, maxHeight: Style.inputHeight),
    constraints: const BoxConstraints(minHeight: 48),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: Style.primaryLightGreyColor,
        style: BorderStyle.solid,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: Colors.lightBlue,
        style: BorderStyle.solid,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: Colors.lightBlue,
        style: BorderStyle.solid,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: Colors.redAccent,
        style: BorderStyle.solid,
        width: 1,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style:  ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: Style.middleSpacing),
      backgroundColor: Style.primaryColor,
      maximumSize:
        const Size(
          double.infinity,
          Style.buttonHeight,
        ),
      minimumSize:
        const Size(
          double.infinity,
          Style.buttonHeight,
        ),
      side:
        const BorderSide(
          color: Style.primaryLightGreyColor,
          style: BorderStyle.solid,
          width: 1,
        ),
      shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(Style.buttonBorderRadius)),
      elevation: 0,
    )
  )
);