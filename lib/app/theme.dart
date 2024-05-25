import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final theme = ThemeData(
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color.fromRGBO(214, 134, 101, 1),
    barBackgroundColor: Color.fromRGBO(214, 134, 101, 1),
    brightness: Brightness.dark,
    textTheme: CupertinoTextThemeData(
      navTitleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.white,
        inherit: false,
      ),
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: const Color.fromRGBO(214, 134, 101, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(17, 17, 17, 1),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 32.sp,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24.sp,
      color: secondaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: disabledColor,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      color: secondaryTextColor,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
    ),
  ),
);

const surfaceColor = Color.fromRGBO(250, 250, 250, 0.08);
const disabledColor = Color.fromRGBO(250, 250, 250, 0.4);
const secondaryTextColor = Color.fromRGBO(250, 250, 250, 1);
final borderRadius = BorderRadius.circular(16.r);
