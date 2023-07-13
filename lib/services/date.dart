import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tanggal {
  static int? year;
  static int? month;
  static int? day;

  static void showDate(BuildContext context,
      void Function(int? year, int? month, int? day)? callback) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      year = selectedDate.year;
      month = selectedDate.month;
      day = selectedDate.day;

      callback?.call(year, month, day);

      print('Tahun: $year');
      print('Bulan: $month');
      print('Tanggal: $day');
    }
  }
}

class TimeRemaining {
  String calculateCountdown(String targetDateString) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy, hh:mm a');
    DateTime targetDate = dateFormat.parse(targetDateString);

    DateTime currentDate = DateTime.now();
    Duration difference = targetDate.difference(currentDate);

    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);

    return '$days day, $hours hours, $minutes minute';
  }
}

bool isDateBeforeNow(String targetDateString) {
  DateFormat dateFormat = DateFormat('dd-MM-yyyy, hh:mm a');
  DateTime targetDate = dateFormat.parse(targetDateString);

  DateTime currentDate = DateTime.now();

  return currentDate.isBefore(targetDate);
}
