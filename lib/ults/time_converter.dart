class TimeConverter {
  static String getTime(String value) {
    String time = "";
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(value));

    if (dateTime.day == DateTime.now().day) {
      time = '${dateTime.hour}:${dateTime.minute}';
    } else {
      time = '${dateTime.day}/${dateTime.month}';
    }
    return time;
  }
}
