// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class TodoModel {
  final String title;
  final String time;
  final int priority;
  bool isCompleted;
  TodoModel(
      {required this.title,
      required this.time,
      required this.priority,
      required this.isCompleted});

  @override
  String toString() {
    return title;
  }
}
