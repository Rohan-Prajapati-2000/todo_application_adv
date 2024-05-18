import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskDialogController extends GetxController {
  var selectedDate = Rxn<DateTime>();

  void packDateTime() async {
    DateTime? pickedDate = await pickDate();
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await pickTime();
      if (pickedTime != null) {
        selectedDate.value = DateTime(
            pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour,
            pickedTime.minute);
      }
    }
  }

  Future<DateTime?> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    return pickedDate;
  }

  Future<TimeOfDay?> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(context: Get.context!,
        initialTime: TimeOfDay.now());
    return pickedTime;
  }
}
