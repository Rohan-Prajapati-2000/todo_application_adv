import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/utils/constants/colors.dart';
import 'data/repositories/authentication/authentication_repositories.dart';
import 'firebase_options.dart';

import 'my_app.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'TODO_CHANNEL_KEY',
        channelKey: 'TODO_CHANNEL_KEY',
        channelName: 'TODO_CHANNEL_NAME',
        channelDescription: 'To-Do Notification channel',
        ledColor: SColors.secondaryColor)
  ], channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: 'TODO_CHANNEL_KEY',
      channelGroupName: 'To-Do Group',
    )
  ]);

  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Widget Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Init Local Storage
  await GetStorage.init();

  // Todo: Initialize Firebase & Firebase Authentication
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  runApp(const MyApp());
}
