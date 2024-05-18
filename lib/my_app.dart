import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/features/authentication/screen/login/login_screen.dart';
import 'package:todo_app/utils/theme/theme.dart';

import 'bindings/general_binding.dart';
import 'notification_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    AwesomeNotifications().setListeners(onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: LoginScreen(),
    );
  }
}
