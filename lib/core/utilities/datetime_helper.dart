import 'package:intl/intl.dart';

import '../../models/cart_data.dart';

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

  bool checkDateWithAdhia({
    required List<NotIncludedDates> notIncludedDates,
    required List<String> adhaDates,
    required String date,
    required String timeHhmm,
  }) {
    DateTime now = DateTime.now();
    DateTime parsedDate = DateTime.parse('${date.trim()} 00:00:00');
    for (int i = 0; i < notIncludedDates.length; i++) {
      if (date.trim() == notIncludedDates[i].deliveryDate!.trim()) return false;
    }
    if (adhaDates.length == 4) {
      if (date.trim() == adhaDates[0] ||
          date.trim() == adhaDates[1] ||
          date.trim() == adhaDates[2] ||
          date.trim() == adhaDates[3]) {
        return false;
      }
    }
    if (now.day == parsedDate.day) {
      return checkPeriod(timeHhmm: timeHhmm, date: date);
    }
    return true;
  }
}
