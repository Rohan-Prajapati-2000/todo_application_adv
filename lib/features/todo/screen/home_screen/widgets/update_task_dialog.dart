import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/features/todo/controller/task_controller/task_controller.dart';
import 'package:todo_app/features/todo/controller/task_dialog_controller/task_dialog_controller.dart';
import 'package:todo_app/features/todo/model/task_model/task_model.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/sizes.dart';
import '../../../../../data/repositories/authentication/authentication_repositories.dart';
import 'save_cancel_button.dart';

class UpdateTaskDialog extends StatelessWidget {
  final String id;
  final TaskModel task;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TaskDialogController controller = Get.put(TaskDialogController());

  UpdateTaskDialog({super.key, required this.id, required this.task})
      : titleController = TextEditingController(text: task.title),
        descriptionController = TextEditingController(text: task.description) {
    controller.selectedDate.value = task.deadLine;
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();

    // Assuming you have a method to get the current user ID
    final String userId = AuthenticationRepository.instance.getCurrentUserId();

    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: SColors.primaryColor,
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => controller.packDateTime(),
                child: Obx(() {
                  final selectedDate = controller.selectedDate.value;
                  if (selectedDate != null) {
                    final formattedDate =
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}, ${selectedDate.hour}:${selectedDate.minute}';
                    return Text(
                      'Target time: $formattedDate',
                      style: TextStyle(color: Colors.green),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    );
                  } else {
                    return Text(
                      'Estimated time to complete the task: Not set, CLICK HERE',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                }),
              ),
              SizedBox(height: SSizes.spaceBtwItems / 2),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: SSizes.spaceBtwItems / 2),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 7,
              ),
              SizedBox(height: SSizes.spaceBtwItems / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SaveAndCancelButton(
                      title: 'Update',
                      onPressed: () async {
                        final selectedDate = controller.selectedDate.value!;
                        final updatedTask = TaskModel(
                          id: id,
                          startDate: task.startDate,
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          deadLine: selectedDate,
                          completionStatus: task.completionStatus,
                          notificationId: task.notificationId,
                          userId: task.userId, // Include the userId here
                        );

                        /// Updating the task
                        taskController.updateTask(updatedTask);

                        /// Clear the field
                        titleController.clear();
                        descriptionController.clear();

                        /// After saving, pop this dialog box
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(width: SSizes.spaceBtwItems / 2),
                  Expanded(
                    child: SaveAndCancelButton(
                      title: 'Cancel',
                      onPressed: () => Get.back(),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}