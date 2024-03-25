import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/feature/todo/domain/model/todo_model.dart';
import 'package:todo/feature/todo/presentation/controller/todo_screen_controller.dart';
import 'package:todo/feature/todo/presentation/widget/custom_text_field.dart';
import 'package:todo/service/notification_service.dart';
import 'package:todo/shared/resources/app_colors.dart';
import 'package:todo/shared/temp/todo_data.dart';

class UtilClass {
  UtilClass._();

  static String formatTime(String time) {
    final DateFormat inputFormat = DateFormat('h:mm a');
    final DateTime dateTime = inputFormat.parse(time);

    final DateFormat outputFormat = DateFormat.Hm();
    final String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  static void showCustomModal(
      {required BuildContext context,
      required TextEditingController titleController,
      required TextEditingController descriptionController,
      required String date,
      required int selectedColor,
      required String formattedTime,
      required TodoScreenController todosService,
      required NotificationService schedule,
      TodoModel? todoModel,
      bool isEdit = false}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: const Color.fromARGB(111, 201, 199, 199),
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        void addTodo() {
          if (titleController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty) {
            final todo = TodoModel(
                title: titleController.text,
                description: descriptionController.text,
                time: formattedTime,
                backgroundColor: selectedColor,
                date: date.toString(),
                id: DateTime.fromMillisecondsSinceEpoch(2)
                    .microsecondsSinceEpoch);
            todosService.addTodo(todo);

            final time = formatTime(todo.time);
            final formattedDate = date.split('/');
            schedule.scheduleNotification(
                year: int.parse(formattedDate[2]),
                month: int.parse(formattedDate[0]),
                day: int.parse(formattedDate[1]),
                hour: int.parse(time.split(":")[0]),
                minute: int.parse(todo.time.split(":")[1].split(" ")[0]),
                todo: todo);
            Navigator.pop(context);
            titleController.clear();
            descriptionController.clear();
            date = DateFormat.yMd().format(DateTime.now());
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: AppColors.fadedRed,
                content: Text(
                  "Title or Description field cannot be empty",
                  style: TextStyle(color: Colors.black),
                )));
          }
        }

        void editTodo() {
          if (titleController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty) {
            todoModel!.title = titleController.text;
            todoModel.description = descriptionController.text;
            todoModel.time = formattedTime;
            todoModel.backgroundColor = selectedColor;
            todoModel.date = date;

            todosService.updateTodo(todoModel);

            final time = formatTime(todoModel.time);
            final formattedDate = date.split('/');
            schedule.scheduleNotification(
                year: int.parse(formattedDate[2]),
                month: int.parse(formattedDate[0]),
                day: int.parse(formattedDate[1]),
                hour: int.parse(time.split(":")[0]),
                minute: int.parse(todoModel.time.split(":")[1].split(" ")[0]),
                todo: todoModel);
            Navigator.pop(context);
            // titleController.clear();
            // descriptionController.clear();
            date = DateFormat.yMd().format(DateTime.now());
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: AppColors.fadedRed,
                content: Text(
                  "Title or Description field cannot be empty",
                  style: TextStyle(color: Colors.black),
                )));
          }
        }

        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.h), topRight: Radius.circular(2.h)),
          child: Container(
            height: 68.h,
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomTextField(
                    controller: titleController,
                    hintText: "Title",
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: "Description",
                    minLines: 1,
                    maxLines: 2,
                  ),
                  Container(
                      height: 20.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.7,
                              color: const Color.fromARGB(52, 126, 126, 126))),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            formattedTime = TimeOfDay.fromDateTime(dateTime)
                                .format(context);
                          });
                        },
                      )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Pick date",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(3000),
                            ).then((value) {
                              setState(() {
                                date = DateFormat.yMd().format(value!);
                              });
                            });
                          },
                          child: const Text("Pick a date"))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.color_lens,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 10),
                          Text("Background color"),
                        ],
                      ),
                      SizedBox(
                        width: 30.w,
                        height: 5.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: TodoData.priorityColor.length,
                            itemBuilder: (context, index) {
                              final color = TodoData.priorityColor[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 1.5.h),
                                  height: 3.h,
                                  width: 3.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index == selectedColor
                                          ? TodoData
                                              .priorityFadedColor[selectedColor]
                                          : null,
                                      border: Border.all(
                                          color: index == selectedColor
                                              ? TodoData
                                                  .priorityColor[selectedColor]
                                              : Colors.transparent)),
                                  child: Center(
                                    child: Container(
                                      height: 3.h,
                                      width: 3.w,
                                      decoration: BoxDecoration(
                                          color: color, shape: BoxShape.circle),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => isEdit ? editTodo() : addTodo(),
                    child: Container(
                      height: 50,
                      width: 100.w,
                      margin: const EdgeInsets.only(bottom: 30),
                      decoration: const BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Center(
                          child: Text(
                        isEdit ? "UPDATE" : "SAVE",
                        style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 2,
                            color: AppColors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
