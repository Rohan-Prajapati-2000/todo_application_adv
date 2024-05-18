import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/data/repositories/task_repository/task_repositories.dart';
import 'package:todo_app/features/todo/controller/task_controller/task_controller.dart';
import 'package:todo_app/features/todo/controller/task_dialog_controller/task_dialog_controller.dart';
import 'package:todo_app/features/todo/model/task_model/task_model.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'package:todo_app/utils/constants/sizes.dart';
import '../../../../../data/repositories/authentication/authentication_repositories.dart';
import 'save_cancel_button.dart';

class TaskDialog extends StatelessWidget {
  TaskDialog({Key? key, this.id});

  final String? id;
  final taskController = Get.find<TaskController>();
  final controller = Get.put(TaskDialogController());
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Assuming you have a method to get the current user ID
    final String userId = AuthenticationRepository.instance.getCurrentUserId();

    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: SColors.primaryColor,
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
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
                        title: 'Save',
                        onPressed: () {
                          final selectedDate = controller.selectedDate.value!;
                          final now = DateTime.now();

                          final newTask = TaskModel(
                            id: UniqueKey().toString(),
                            startDate: now,
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            deadLine: selectedDate,
                            notificationId: UniqueKey().hashCode,
                            userId: userId, // Include the userId here
                          );

                          // Adding new task to Firestore
                          TaskRepository().addTask(userId, newTask);

                          // Clear the fields
                          titleController.clear();
                          descriptionController.clear();

                          // After saving, pop this dialog box
                          Get.back();

                          // Add the new task to the list
                          taskController.addTask(newTask);
                        },
                      ),
                    ),
                    SizedBox(width: SSizes.spaceBtwItems / 2),
                    Expanded(
                      child: SaveAndCancelButton(
                        title: 'Cancel',
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



