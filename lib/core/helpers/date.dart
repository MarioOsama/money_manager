class DateHelper {
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

  static String? toDateFormat(String stringDate) {
    final String wantedDateFragment = splitWantedDateFragment(stringDate);
    final List<String> stringDateFragments = wantedDateFragment.split('-');
    if (stringDateFragments.length != 3 ||
        stringDateFragments[0].length != 4 ||
        stringDateFragments[1].length != 2 ||
        stringDateFragments[2].length != 2) {
      return null;
    }
    final List<int?>? intDateFragments =
        _checkIntDateFormat(stringDateFragments);
    final bool isValidDateValues = intDateFragments != null;

    if (!isValidDateValues) {
      return null;
    }

    final String validDate = intDateFragments.join('-');
    final String formattedDate = validDate
        .split('-')
        .map((dateFragment) =>
            dateFragment.length == 1 ? '0$dateFragment' : dateFragment)
        .join('-');
    return formattedDate;
  }

  static String splitWantedDateFragment(String stringDate) {
    return stringDate.trim().split(' ').first;
  }

  static List<int?>? _checkIntDateFormat(List<String> dateFragments) {
    final List<int?> intFragmentsList = dateFragments
        .map((stringDateFragment) => int.tryParse(stringDateFragment))
        .toList();
    if (intFragmentsList.contains(null) ||
        intFragmentsList[0]! < 2000 ||
        intFragmentsList.contains(0) ||
        intFragmentsList[1]! > 12 ||
        intFragmentsList[2]! > 31) {
      return null;
    }
    return intFragmentsList;
  }
}
