import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/features/todo/model/task_model/task_model.dart';
import 'package:todo_app/utils/popups/loaders.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Method to fetch tasks for a specific user from Firestore
  Future<List<TaskModel>> getTasks(String userId) async {
    List<TaskModel> tasks = [];
    try {
      final querySnapshot = await _firestore.collection('users')
          .doc(userId)
          .collection('tasks')
          .get();
      for (var task in querySnapshot.docs) {
        tasks.add(TaskModel.fromSnapshot(task));
      }
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to fetch tasks: $e');
    }
    return tasks;
  }

  /// Method to add a new task for a specific user to Firestore
  Future<void> addTask(String userId, TaskModel task) async {
    try {
      await _firestore.collection('users')
          .doc(userId)
          .collection('tasks')
          .add(task.toMap());
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to add task: $e');
    }
  }

  /// Method to update an existing task for a specific user in Firestore
  Future<void> updateTask(String userId, String taskId, TaskModel task) async {
    try {
      await _firestore.collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update(task.toMap());
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to update task: $e');
    }
  }

  /// Method to delete an existing task for a specific user from Firestore
  Future<void> deleteTask(String userId, String taskId) async {
    try {
      await _firestore.collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Failed to delete task: $e');
    }
  }

  /// Method to update the completion status of a task for a specific user in Firestore
  Future<void> updateCompletionStatus(String userId, String taskId, bool status) async {
    try {
      await _firestore.collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update({'completionStatus': status});
    } catch (e) {
      SLoaders.errorSnackBar(title: "Error: $e");
    }
  }
}

