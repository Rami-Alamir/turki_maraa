import 'package:intl/intl.dart';

class DateTimeHelper {
  bool checkPeriod({
    required String timeHhmm,
    required String date,
  }) {
    DateTime now = DateTime.now();
    DateTime parsedDate = DateTime.parse('${date.trim()} 00:00:00');
    if (now.day != parsedDate.day) {
      return true;
    }
    try {
      DateTime now = DateTime.now();
      DateTime parsedDate =
          DateTime.parse('${DateFormat('yyyy-MM-dd').format(now)} $timeHhmm');
      return parsedDate.compareTo(now) > 0;
    } catch (_) {}
    return true;
  }

  bool checkDate({
    required String date,
    required String timeHhmm,
  }) {
    DateTime now = DateTime.now();
    DateTime parsedDate = DateTime.parse('${date.trim()} 00:00:00');
    if (timeHhmm.isEmpty) {
      return false;
    }
    if (now.day == parsedDate.day) {
      return checkPeriod(timeHhmm: timeHhmm, date: date);
    }
    return true;
  }
}
