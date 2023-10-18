import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/shared/resources/app_colors.dart';
import 'package:todo/shared/resources/app_strings.dart';
import 'package:todo/shared/temp/todo_data.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SizedBox(
      width: width,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.appName,
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
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
            Expanded(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    elevation: 1,
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.recommend_sharp),
                      ),
                      title: const Text("Meet Ann"),
                      subtitle: const Text("8:00 PM"),
                      trailing: SizedBox(
                        width: width * 0.12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    barrierColor: const Color.fromARGB(158, 201, 199, 199),
                    context: context,
                    builder: (context) => ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Container(
                            height: height * 0.7,
                            color: AppColors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.006,
                                    width: width * 0.13,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: AppColors.grey),
                                  ),
                                  Container(
                                    height: height * 0.05,
                                    margin: const EdgeInsets.only(
                                        bottom: 15, top: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  87, 130, 128, 255),
                                              spreadRadius: 2,
                                              blurRadius: 5)
                                        ],
                                        border:
                                            Border.all(color: AppColors.purple),
                                        color: AppColors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6))),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      Switch(
                                        activeColor: AppColors.white,
                                        activeTrackColor: AppColors.lightGreen,
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
                                            color: const Color.fromARGB(
                                                52, 126, 126, 126))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //HOURS WHEEL
                                        SizedBox(
                                          width: 70,
                                          child:
                                              ListWheelScrollView.useDelegate(
                                                  perspective: 0.002,
                                                  physics:
                                                      const FixedExtentScrollPhysics(),
                                                  diameterRatio: 1.2,
                                                  itemExtent: 50,
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                          childCount: 13,
                                                          builder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5.0),
                                                              child: Center(
                                                                child: Text(
                                                                  index < 10
                                                                      ? "0$index"
                                                                      : index
                                                                          .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        40,
                                                                    color: Colors
                                                                        .black45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          })),
                                        ),

                                        const Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.black),
                                        ),

                                        //MINUTE WHEEL
                                        SizedBox(
                                          width: 70,
                                          child:
                                              ListWheelScrollView.useDelegate(
                                                  perspective: 0.005,
                                                  physics:
                                                      const FixedExtentScrollPhysics(),
                                                  diameterRatio: 1.2,
                                                  itemExtent: 50,
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                          childCount: 60,
                                                          builder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5.0),
                                                              child: Center(
                                                                child: Text(
                                                                  index < 10
                                                                      ? "0$index"
                                                                      : index
                                                                          .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        40,
                                                                    color: Colors
                                                                        .black45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          })),
                                        ),

                                        //AM OR PM

                                        SizedBox(
                                          width: 70,
                                          child:
                                              ListWheelScrollView.useDelegate(
                                                  perspective: 0.005,
                                                  physics:
                                                      const FixedExtentScrollPhysics(),
                                                  diameterRatio: 1.2,
                                                  itemExtent: 50,
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                          childCount: 2,
                                                          builder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5.0),
                                                              child: Center(
                                                                child: Text(
                                                                  index == 0
                                                                      ? "AM"
                                                                      : "PM",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        40,
                                                                    color: Colors
                                                                        .black45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          })),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: AppColors.grey,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Remind me",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                          TodoData.remindMeList.length,
                                          (index) {
                                        final remindMeString =
                                            TodoData.remindMeList[index];
                                        return ChoiceChip(
                                            label: Text(
                                              remindMeString,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            selected: false);
                                      })),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        children: List.generate(
                                            TodoData.priorityColor.length,
                                            (index) {
                                          final color =
                                              TodoData.priorityColor[index];
                                          final fadedColor = TodoData
                                              .priorityFadedColor[index];
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            height: height * 0.06,
                                            width: width * 0.06,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: fadedColor,
                                                border:
                                                    Border.all(color: color)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7))),
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
                        ));
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
            ),
          ],
        ),
      ),
    ));
  }
}
