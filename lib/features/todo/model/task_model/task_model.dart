import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime deadLine;
  final DateTime startDate;
  bool completionStatus;
  late int notificationId;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.deadLine,
    required this.startDate,
    this.completionStatus = false,
    required this.notificationId,
  });

  factory TaskModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TaskModel(
      id: snapshot.id,
      userId: data['userId'],
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      deadLine: (data['deadLine'] as Timestamp).toDate(),
      completionStatus: data['completionStatus'] ?? false,
      notificationId: data['notificationId'] ?? UniqueKey().hashCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'deadLine': deadLine,
      'startDate': startDate,
      'completionStatus': completionStatus,
      'notificationId': notificationId,
    };
  }
}

