import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/shared/resources/app_colors.dart';
import 'package:todo/shared/resources/app_strings.dart';
import 'package:todo/shared/temp/todo_data.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  bool isCompleted = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SizedBox(
      width: width,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                height: height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.appName,
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Tuesday, March 12",
                          style: TextStyle(fontSize: 18, color: Colors.black45),
                        ),
                        IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            alignment: Alignment.bottomCenter,
                            icon: const Icon(
                              Icons.calendar_month,
                              color: AppColors.purple,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: DatePicker(
                        DateTime.now(),
                        daysCount: 7,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: AppColors.fadePdurple,
                        selectedTextColor: Colors.black,
                        onDateChange: (date) {},
                      ),
                    ),
                  ),
                  Slidable(
                    endActionPane:
                        const ActionPane(motion: StretchMotion(), children: [
                      CircleAvatar(
                        backgroundColor: AppColors.fadedRed,
                        child: Icon(
                          Icons.delete,
                          color: AppColors.lightRed,
                        ),
                      )
                    ]),
                    child: Card(
                      shape: isCompleted
                          ? const StadiumBorder(
                              side: BorderSide(color: AppColors.lightOrange))
                          : null,
                      color: isCompleted
                          ? Colors.transparent
                          : const Color.fromARGB(255, 243, 243, 252),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      elevation: isCompleted ? 0 : 2,
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            setState(() {
                              isCompleted = !isCompleted;
                            });
                          },
                          child: isCompleted
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isCompleted = !isCompleted;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: AppColors.lightOrange,
                                  ))
                              : Container(
                                  height: height * 0.1,
                                  width: width * 0.1,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: AppColors.grey,
                                          width: width * 0.004)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.check,
                                  ))),
                        ),
                        title: Text(
                          "Meet Ann",
                          style: TextStyle(
                              color: isCompleted
                                  ? const Color(0xFF9D9DA1)
                                  : Colors.black),
                        ),
                        subtitle: isCompleted ? null : const Text("8:00 PM"),
                        trailing: SizedBox(
                          width: width * 0.12,
                          child: isCompleted
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: height * 0.03,
                                      width: width * 0.03,
                                      decoration: const BoxDecoration(
                                          color: AppColors.lightGreen,
                                          shape: BoxShape.circle),
                                    ),
                                    const Icon(Icons.notifications),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  barrierColor: const Color.fromARGB(111, 201, 199, 199),
                  context: context,
                  builder: (context) => ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      height: height * 0.7,
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.006,
                              width: width * 0.13,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: AppColors.grey),
                            ),
                            Container(
                              height: height * 0.05,
                              margin:
                                  const EdgeInsets.only(bottom: 15, top: 10),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(87, 130, 128, 255),
                                        spreadRadius: 2,
                                        blurRadius: 5)
                                  ],
                                  border: Border.all(color: AppColors.purple),
                                  color: AppColors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6))),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintText: "Make a Cake",
                                      ),
                                    )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.alarm,
                                      color: AppColors.grey,
                                    ),
                                    SizedBox(width: 10),
                                    Text("10:00 AM"),
                                  ],
                                ),
                                CupertinoSwitch(
                                  activeColor: AppColors.lightGreen,
                                  value: true,
                                  onChanged: (value) {},
                                )
                              ],
                            ),
                            Container(
                                height: height * 0.2,
                                width: width * 0.8,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.7,
                                        color: const Color.fromARGB(
                                            52, 126, 126, 126))),
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: DateTime.now(),
                                  use24hFormat: true,
                                  onDateTimeChanged: (dateTime) {},
                                )),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: AppColors.grey,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Remind me",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    TodoData.remindMeList.length, (index) {
                                  final remindMeString =
                                      TodoData.remindMeList[index];
                                  return ChoiceChip(
                                    selectedColor: AppColors.purple,
                                    disabledColor: AppColors.fadedGrey,
                                    label: Text(
                                      remindMeString,
                                      style: index == 0
                                          ? const TextStyle(color: Colors.white)
                                          : const TextStyle(
                                              color: Colors.black),
                                    ),
                                    selected: index == 0 ? true : false,
                                  );
                                })),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: AppColors.grey,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Priority"),
                                  ],
                                ),
                                Row(
                                  children: List.generate(3, (index) {
                                    final color = TodoData.priorityColor[index];
                                    final fadedColor =
                                        TodoData.priorityFadedColor[index];
                                    return Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: height * 0.06,
                                      width: width * 0.06,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: fadedColor,
                                          border: Border.all(color: color)),
                                      child: Center(
                                        child: Container(
                                          height: height * 0.03,
                                          width: width * 0.03,
                                          decoration: BoxDecoration(
                                              color: color,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: width,
                                margin: const EdgeInsets.only(bottom: 30),
                                decoration: const BoxDecoration(
                                    color: AppColors.purple,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                child: const Center(
                                    child: Text(
                                  "SAVE",
                                  style: TextStyle(
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
                  ),
                );
              },
              child: Container(
                height: height * 0.05,
                margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.purple),
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "What do you need to do?",
                      style: TextStyle(fontSize: 18, color: Colors.black45),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
