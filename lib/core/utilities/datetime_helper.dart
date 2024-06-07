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
    required List<NotIncludedDates> notIncludedDates,
    required String date,
    required String timeHhmm,
  }) {
    DateTime now = DateTime.now();
    DateTime parsedDate = DateTime.parse('${date.trim()} 00:00:00');
    for (int i = 0; i < notIncludedDates.length; i++) {
      if (date.trim() == notIncludedDates[i].deliveryDate!.trim()) return false;
    }
    if (now.day == parsedDate.day) {
      return checkPeriod(timeHhmm: timeHhmm, date: date);
    }
    return true;
  }

  bool checkDateWithAdhia(
      {required List<NotIncludedDates> notIncludedDates,
      required String date,
      required String timeHhmm,
      required bool withAdhia}) {
    DateTime now = DateTime.now();
    DateTime parsedDate = DateTime.parse('${date.trim()} 00:00:00');
    for (int i = 0; i < notIncludedDates.length; i++) {
      if (date.trim() == notIncludedDates[i].deliveryDate!.trim()) return false;
    }
    if (withAdhia) {
      if (date.trim() == '2024-06-16' ||
          date.trim() == '2024-06-17' ||
          date.trim() == '2024-06-18' ||
          date.trim() == '2024-06-19') return false;
    }
    if (now.day == parsedDate.day) {
      return checkPeriod(timeHhmm: timeHhmm, date: date);
    }
    return true;
  }
}
