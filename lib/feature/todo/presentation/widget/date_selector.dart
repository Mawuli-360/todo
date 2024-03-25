import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/feature/todo/presentation/controller/todo_screen_controller.dart';
import 'package:todo/shared/resources/app_colors.dart';

class DateSelector extends ConsumerWidget {
  const DateSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateChange = ref.watch(dateTimeChangeProvider.notifier);
    return SizedBox(
      height: 11.h,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: DatePicker(
          DateTime.now(),
          daysCount: 7,
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColors.fadePdurple,
          selectedTextColor: Colors.black,
          onDateChange: (date) => dateChange.changeDateTime(date),
        ),
      ),
    );
  }
}
