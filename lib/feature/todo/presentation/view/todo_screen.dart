import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/common_widgets/async_value_widget.dart';
import 'package:todo/feature/todo/presentation/controller/todo_screen_controller.dart';
import 'package:todo/feature/todo/presentation/widget/date_selector.dart';
import 'package:todo/feature/todo/presentation/widget/header.dart';
import 'package:todo/feature/todo/presentation/widget/submission_modal.dart';
import 'package:todo/feature/todo/presentation/widget/todo_card.dart';
import 'package:todo/shared/resources/app_images.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final todoProvider = ref.watch(todoScreenControllerProvider);
    final selectedDate = ref.watch(dateTimeChangeProvider);

    bool isDateLessThanToday(DateTime date) {
      final now = DateTime.now();
      final formattedDateString = DateFormat('yyyy-MM-dd').format(now);
      final formattedDateTime =
          DateTime.parse('$formattedDateString 00:00:00.000');
      return date.isBefore(formattedDateTime);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("NO"),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: const Text("YES"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
          body: SizedBox(
        width: 100.w,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 1.h),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: IconButton(
              //       onPressed: () => ref
              //           .read(themeChangeProvider.notifier)
              //           .setThemeChanger(),
              //       padding: EdgeInsets.zero,
              //       icon: Icon(
              //         isDark
              //             ? Icons.dark_mode_outlined
              //             : Icons.wb_sunny_outlined,
              //         size: 4.h,
              //       )),
              // ),

              const Header(),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const DateSelector(),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                        child: AsyncValueWidget(
                      value: todoProvider,
                      data: (data) {
                        if (data.isNotEmpty) {
                          final todosOfSelectedDate = data
                              .where((todo) => todo.date == selectedDate)
                              .toList();

                          if (todosOfSelectedDate.isNotEmpty) {
                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final todo = data[index];
                                  final date = data[index].date;
                                  final dateTime =
                                      DateFormat('M/d/yyyy').parse(date);
                                  final isDateLess =
                                      isDateLessThanToday(dateTime);

                                  if (isDateLess == true) {
                                    ref
                                        .read(todoScreenControllerProvider
                                            .notifier)
                                        .delete(index);
                                  }

                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      child: FadeInAnimation(
                                        duration:
                                            const Duration(milliseconds: 800),
                                        child: TodoCard(
                                          index: index,
                                          todo: todo,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AppImages.note,
                                  height: 170,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "No Todo For Today",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            );
                          }
                        } else {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AppImages.note,
                                height: 170,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "No Todo Found",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
              const SubmissionModal()
            ],
          ),
        ),
      )),
    );
  }
}
