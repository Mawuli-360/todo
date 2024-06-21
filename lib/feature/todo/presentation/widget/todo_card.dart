import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/feature/todo/domain/model/todo_model.dart';
import 'package:todo/feature/todo/presentation/controller/todo_screen_controller.dart';
import 'package:todo/service/notification_service.dart';
import 'package:todo/shared/resources/app_colors.dart';
import 'package:todo/shared/temp/todo_data.dart';
import 'package:todo/shared/utils/modal_sheet.dart';

class TodoCard extends ConsumerStatefulWidget {
  const TodoCard({
    super.key,
    required this.index,
    required this.todo,
  });

  final int index;
  final TodoModel todo;

  @override
  ConsumerState<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends ConsumerState<TodoCard> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController =
        TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(todoScreenControllerProvider.notifier);
    String formattedTime = TimeOfDay.now().format(context);

    return widget.todo.isCompleted
        ? Slidable(
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                  backgroundColor: AppColors.fadedRed,
                  icon: Icons.delete,
                  foregroundColor: AppColors.lightRed,
                  onPressed: (context) => controller.delete(widget.index)),
            ]),
            child: Container(
              margin: EdgeInsets.only(right: 2.h, left: 2.h, bottom: 1.h),
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              height: 6.h,
              decoration: ShapeDecoration(
                  color:
                      TodoData.priorityFadedColor[widget.todo.backgroundColor],
                  shape: StadiumBorder(
                      side: BorderSide(
                          color: TodoData
                              .priorityColor[widget.todo.backgroundColor]))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      widget.todo.title,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.5.h),
                    child: OutlinedButton(
                        onPressed: () => controller.updateComplete(widget.todo),
                        style: ButtonStyle(
                            foregroundColor: WidgetStateColor.resolveWith(
                                (states) => Colors.black)),
                        child: const Row(
                          children: [
                            Icon(Icons.check),
                            Text("Completed"),
                          ],
                        )),
                  )
                ],
              ),
            ),
          )
        : Slidable(
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                  backgroundColor: AppColors.fadedRed,
                  icon: Icons.delete,
                  foregroundColor: AppColors.lightRed,
                  onPressed: (context) => controller.delete(widget.index)),
              SlidableAction(
                  backgroundColor: AppColors.fadedGreen,
                  icon: Icons.edit,
                  foregroundColor: AppColors.lightGreen,
                  onPressed: (context) {
                    setState(() {
                      isEdit = true;
                    });
                    UtilClass.showCustomModal(
                      context: context,
                      titleController: titleController,
                      descriptionController: descriptionController,
                      date: widget.todo.date,
                      selectedColor: widget.todo.backgroundColor,
                      formattedTime: formattedTime,
                      todosService:
                          ref.watch(todoScreenControllerProvider.notifier),
                      schedule: ref.watch(notificationServiceProvider),
                      isEdit: isEdit,
                      todoModel: widget.todo,
                    );
                    setState(() {
                      isEdit = false;
                    });
                  })
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: TodoData
                            .priorityColor[widget.todo.backgroundColor]),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                color: TodoData.priorityFadedColor[widget.todo.backgroundColor],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: ExpansionTile(
                    shape: Border.all(color: Colors.transparent),
                    title: Text(
                      widget.todo.title,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        controller.updateComplete(widget.todo);
                      },
                      child: Container(
                        height: 4.h,
                        width: 4.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.purple),
                            shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(
                            Icons.check,
                            color: AppColors.purple,
                          ),
                        ),
                      ),
                    ),
                    expandedAlignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Description ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2.h),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, bottom: 10, right: 10),
                        child: Text(widget.todo.description),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
