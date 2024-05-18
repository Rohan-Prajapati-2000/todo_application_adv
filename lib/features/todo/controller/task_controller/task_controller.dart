import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/utils/popups/loaders.dart';

import '../../../../data/repositories/task_repository/task_repositories.dart';
import '../../model/task_model/task_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  String userId;

  TaskController(this.userId);

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  /// Fetching tasks for the current user
  void fetchTasks() async {
    try {
      var taskList = await TaskRepository().getTasks(userId);
      tasks.assignAll(taskList);
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Error $e');
    }
  }

  /// Adding task for the current user
  void addTask(TaskModel task) {
    task.notificationId = UniqueKey().hashCode;
    tasks.add(task);
    TaskRepository().addTask(userId, task);
    scheduleNotification(task);
  }

  /// Updating task for the current user
  void updateTask(TaskModel task) async {
    try {
      await TaskRepository().updateTask(userId, task.id, task);
      int index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
        tasks.refresh();
        scheduleNotification(task);
      }
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to update task: $e');
    }
  }

  /// Deleting task for the current user
  void deleteTask(TaskModel task) async {
    try {
      await TaskRepository().deleteTask(userId, task.id);
      tasks.remove(task);
      AwesomeNotifications().cancel(task.notificationId);
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to delete task: $e');
    }
  }

  /// Updating completion status for the current user's task
  Future<void> updateCompletionStatus(String taskId, bool status) async {
    try {
      await TaskRepository().updateCompletionStatus(userId, taskId, status);
      var taskIndex = tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        tasks[taskIndex].completionStatus = status;
        if (status) {
          AwesomeNotifications().cancel(tasks[taskIndex].notificationId);
        }
        tasks.refresh();
      }
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to update task status: $e');
    }
  }

  /// Notification Schedule
  void scheduleNotification(TaskModel task) {
    DateTime notificationTime = task.deadLine.subtract(Duration(minutes: 10));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: task.notificationId,
        channelKey: 'TODO_CHANNEL_KEY',
        title: 'Upcoming Deadline',
        body: 'Task ${task.title} is due in 10 minutes!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: notificationTime),
    );
  }
}


