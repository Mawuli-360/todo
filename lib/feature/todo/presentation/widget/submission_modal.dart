import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/feature/todo/presentation/controller/todo_screen_controller.dart';
import 'package:todo/service/notification_service.dart';
import 'package:todo/shared/resources/app_colors.dart';
import 'package:todo/shared/utils/modal_sheet.dart';

class SubmissionModal extends ConsumerStatefulWidget {
  const SubmissionModal({
    super.key,
  });

  @override
  ConsumerState<SubmissionModal> createState() => _SubmissionModalState();
}

class _SubmissionModalState extends ConsumerState<SubmissionModal> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int selectedColor = 0;
  int selectedRemindMe = 0;
  String date = DateFormat.yMd().format(DateTime.now());

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosService = ref.watch(todoScreenControllerProvider.notifier);
    final schedule = ref.read(notificationServiceProvider);
    String formattedTime = TimeOfDay.now().format(context);

    return GestureDetector(
      onTap: () => UtilClass.showCustomModal(
          context: context,
          titleController: titleController,
          descriptionController: descriptionController,
          date: date,
          selectedColor: selectedColor,
          formattedTime: formattedTime,
          todosService: todosService,
          schedule: schedule,),
      child: Container(
        height: 5.h,
        margin: EdgeInsets.only(bottom: 4.h, left: 1.5.h, right: 1.5.h),
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
    );
  }
}
