import 'package:intl/intl.dart';

class DateTimeUtils {
  static String convertDateTimeToString(DateTime dateTime, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime convertStringToDateTime(String dateTime, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).parse(dateTime);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  static bool isSameDateTime(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day && date1.hour == date2.hour && date1.minute == date2.minute;
  }
}
