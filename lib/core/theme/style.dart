
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Style {
  static const double baseUnit = 4.0;

  static const double tinySpacing = baseUnit;
  static const double smallSpacing = baseUnit * 2;
  static const double middleSpacing = baseUnit * 3;
  static const double defaultSpacing = baseUnit * 4;
  static const double bigSpacing = baseUnit * 5;
  static const double largeSpacing = baseUnit * 6;
  static const double mapBoundsPadding = 60.0;

  static const double inputHeight = 50.0;
  static const double defaultPaddingVertical = 30.0;

  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 10.0;
  static const defaultIconSize = baseUnit * 6;

  static const double bottomNavigatorBarHeight = 55.0;
  static double bottomNavigatorItemWidth = 80;

  static double defaultSplashRadius = 10;

  static double drawerItemHeight = 50;

  static const Color primaryColor = Color(0xFF221654);
  static const Color primarySecondColor = Color(0xFFF1612D);
  static const Color primaryErrorColor = Color(0xFFEE5E37);
  static const Color primaryLightGreyColor = Color(0xFFD0C9D8);
  static const Color primaryWhiteColor = Color(0xFFFFFFFF);
  static const Color primaryBlackColor = Color(0xFF242424);


  static const Color hintTextColor = Color(0xFFD9D9D9);
  static const Color dividerGreyColor = Color(0xFFF5F5F5);

  static const formButtonText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Style.primaryWhiteColor,
  );

  static const titleText = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: primaryBlackColor,
  );

  static const authPageTitleText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: Style.primaryWhiteColor,
  );

  static const buttonText = TextStyle(
    color: Style.primaryWhiteColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const mainText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: primaryBlackColor,
  );

  static const smallText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: primaryBlackColor,
  );

  static const bigText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: primaryBlackColor,
  );

  static const iconText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: primaryWhiteColor,
  );

  static const noticeableText = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: primaryColor,
  );

  static const textFormFieldStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: primaryBlackColor,
  );
  // static final formButtonDecoration = ElevatedButton.styleFrom(
  //   backgroundColor: Style.primaryLightGreyColor,
  // );

  static final formFieldDecoration = InputDecoration(
    constraints: const BoxConstraints(minHeight: 51),
    hintStyle: const TextStyle(
      letterSpacing: 1,
      fontWeight: FontWeight.w400,
      color: Style.primaryLightGreyColor
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(color: Style.primaryColor, width: 1),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: Style.primaryLightGreyColor, width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(color: Style.primaryLightGreyColor, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(color: Style.primaryLightGreyColor, width: 1),
    ),
    fillColor: Colors.transparent,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(color: Style.primaryErrorColor, width: 1),
    ),
  );

  static const formShadows = <BoxShadow>[
  BoxShadow(color: Color(0x0A000000), spreadRadius: -5, blurRadius: 10, offset: Offset(0, 10)),
  BoxShadow(color: Color(0x33186980), spreadRadius: -5, blurRadius: 25, offset: Offset(12, 12))
  ];

  static const itemShadows = <BoxShadow>[
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      offset: Offset(0, 0),
    ),
  ];

  static const dialogShadows = <BoxShadow>[
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 4),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];
  static const inlineTextInputStyle = InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Style.primaryLightGreyColor,
        width: 2,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Style.primaryColor,
        width: 2,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Style.primaryErrorColor,
        width: 2,
      ),
    ),
    constraints: BoxConstraints(maxHeight: 80),
  );

  static final defaultDateFormat = DateFormat('dd MMM HH:mm', 'ru');
  static final defaultWithYearDateFormat = DateFormat('dd MMM yyyy', 'ru');
  static final defaultTimeDateFormat = DateFormat('HH:mm');
  static final greenSpaceDateFormat = DateFormat('dd.MM.yy');
}
