import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TimeFormatHelper {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  static String justDateWithUnderscoll(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String dateMountFormat(DateTime date) {
    return DateFormat('dd\n MMM ').format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }


  static timeWithAMPM(String time){
    DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }

  // static Future<void> isFutureDate(String input) async {
  //   try {
  //     DateTime date = DateTime.parse(input);
  //     DateTime now = DateTime.now();
  //     await PrefsHelper.setBool(AppConstants.isFutureDate, date.isAfter(now));
  //   } catch (e) {
  //     PrefsHelper.setBool(AppConstants.isFutureDate, false);
  //   }
  // }
  //

  //===============================> Show Clock Function <=======================
  static Future<void> selectTime(BuildContext context, Function(String) onTimeSelected) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final hours = pickedTime.hour.toString().padLeft(2, '0');
      final minutes = pickedTime.minute.toString().padLeft(2, '0');
      final time = "$hours:$minutes";
      onTimeSelected(time);
      print('Selected time: $time');
    }
  }


}
