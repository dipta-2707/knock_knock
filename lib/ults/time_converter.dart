import 'package:get/get.dart';

class TimeConverter {
  static String getTime(int value) {
    String time = "";
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value);

    if (dateTime.day == DateTime.now().day) {
      time = '${dateTime.hour}:${dateTime.minute}';
    } else {
      time = '${dateTime.day}-${dateTime.month}';
    }
    return time;
  }
}
