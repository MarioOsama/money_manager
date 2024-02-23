class DateHelper {
  static String getFormattedDate(DateTime date) {
    final String month = date.month.toString();
    final String day = date.day.toString();
    final String year = date.year.toString();
    return '$day-$month-$year';
  }

  static String getPeriodicDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
