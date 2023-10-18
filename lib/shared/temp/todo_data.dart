import 'package:flutter/material.dart';
import 'package:todo/shared/resources/app_colors.dart';

class TodoData {
  TodoData._();

  static List<String> remindMeList = [
    "In 24 hours",
    "An hour before",
    "15 min before"
  ];

  static List<Color> priorityColor = [
    AppColors.lightGreen,
    AppColors.lightOrange,
    AppColors.lightRed
  ];

  static List<Color> priorityFadedColor = [
    AppColors.fadedGreen,
    AppColors.fadedOrange,
    AppColors.fadedRed
  ];
}
