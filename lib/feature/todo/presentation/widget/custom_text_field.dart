import 'package:flutter/material.dart';

import 'package:todo/shared/resources/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.minLines,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(87, 130, 128, 255),
                spreadRadius: 2,
                blurRadius: 5)
          ],
          border: Border.all(color: AppColors.purple),
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: controller,
            minLines: minLines,
            maxLines: maxLines,
            onChanged: (value) {},
            onFieldSubmitted: (value) {},
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: hintText,
            ),
          )),
    );
  }
}
