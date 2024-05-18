import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:todo_app/features/todo/screen/home_screen/widgets/update_task_dialog.dart';

import '../../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/task_controller/task_controller.dart';
import 'widgets/dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user's ID
    final String userId = AuthenticationRepository.instance.getCurrentUserId();

    // Initialize TaskController with userId
    final taskController = Get.put(TaskController(userId));

    /// Date formatting
    String formatDateTime(DateTime dateTime) {
      return DateFormat('yyyy MMM dd HH:mm').format(dateTime);
    }

    return Scaffold(
      backgroundColor: SColors.primaryColor,
      appBar: AppBar(
        backgroundColor: SColors.secondaryColor,
        elevation: 10,
        title: Text('Todo App',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.black)),
        actions: [
          IconButton(
              icon: Icon(
                Iconsax.logout,
                color: Colors.black,
              ),
              onPressed: () => AuthenticationRepository.instance.logOut()),
          SizedBox(width: SSizes.spaceBtwItems / 2)
        ],
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(
              child: Text('No tasks available',
                  style: TextStyle(color: Colors.black)));
        } else {
          return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              final task = taskController.tasks[index];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Get.dialog(UpdateTaskDialog(id: task.id, task: task));
                      },
                      backgroundColor: CupertinoColors.activeBlue,
                      foregroundColor: CupertinoColors.white,
                      icon: Icons.edit,
                      label: "Edit",
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        taskController.deleteTask(task);
                      },
                      backgroundColor: CupertinoColors.destructiveRed,
                      foregroundColor: CupertinoColors.white,
                      icon: Icons.delete,
                      label: "Delete",
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: SSizes.spaceBtwItems / 2),
                  child: Stack(
                    children: [
                      Card(
                        color: SColors.secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(SSizes.defaultSpace),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: SSizes.spaceBtwItems),

                              /// Start date
                              Container(
                                  width: double.infinity,
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: SSizes.defaultSpace,
                                        vertical: SSizes.defaultSpace / 4),
                                    child: Text(
                                        'Start Date: ${formatDateTime(task.startDate)}',
                                        style: TextStyle(color: Colors.black)),
                                  )),
                              SizedBox(height: SSizes.spaceBtwItems / 4),

                              /// Deadline Date
                              Container(
                                  width: double.infinity,
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: SSizes.defaultSpace,
                                        vertical: SSizes.defaultSpace / 4),
                                    child: Text(
                                        'Deadline: ${formatDateTime(task.deadLine)}',
                                        style: TextStyle(color: Colors.black)),
                                  )),

                              SizedBox(height: SSizes.spaceBtwItems / 4),

                              /// Title
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SSizes.defaultSpace,
                                    vertical: SSizes.defaultSpace / 4),
                                child: Text(
                                  'Title: ${task.title}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(color: Colors.black),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              /// Description
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SSizes.defaultSpace,
                                    vertical: SSizes.defaultSpace / 4),
                                child: ReadMoreText(
                                  'Description: ${task.description}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  trimExpandedText: '  Show less',
                                  trimCollapsedText: '  Show more',
                                  moreStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                      color:
                                      CupertinoColors.activeBlue),
                                  lessStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                      color:
                                      CupertinoColors.activeBlue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Checkbox positioned on the top right
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: task.completionStatus,
                            onChanged: (bool? value) {
                              if (value != null) {
                                taskController.updateCompletionStatus(
                                    task.id, value);
                              }
                            },
                            activeColor: CupertinoColors.activeBlue,
                            checkColor: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: SColors.secondaryColor,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          elevation: 10,
          onPressed: () {
            Get.dialog(TaskDialog());
          }),
    );
  }
}
