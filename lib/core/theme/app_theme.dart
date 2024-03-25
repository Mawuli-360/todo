import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/shared/resources/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    splashColor: Colors.transparent,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.fadedOrange,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    splashColor: const Color.fromARGB(142, 0, 0, 0),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
    inputDecorationTheme: const InputDecorationTheme(),
    primaryColor: AppColors.fadedOrange,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontSize: 14.sp),
    ),
  );
}
