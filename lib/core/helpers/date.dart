import 'package:easy_localization/easy_localization.dart';
import 'package:money_manager/core/helpers/app_string.dart';

class DateHelper {
  static String getPeriodicDate(DateTime date) {
    final now = DateTime.now().toLocal();
    final diff = now.difference(date);
    if (diff.inDays > 0) {
      switch (diff.inDays) {
        case 1:
          return AppString.yesterday.tr();
        case > 1 && <= 7:
          return '${diff.inDays} ${AppString.daysAgo.tr()}';
        case > 7 && <= 14:
          return AppString.lastWeek.tr();
        case > 14 && <= 21:
          return '2 ${AppString.weeksAgo.tr()}';
        case > 21 && <= 28:
          return '3 ${AppString.weeksAgo.tr()}';
        case > 28 && <= 31:
          return AppString.lastMonth.tr();
        case > 31 && <= 365:
          return '${diff.inDays ~/ 30} ${AppString.monthsAgo.tr()}';
        case > 365:
          return '${diff.inDays ~/ 365} ${AppString.yearsAgo.tr()}';
        default:
          return 'Unknown';
      }
    } else if (diff.inHours > 0) {
      return '${diff.inHours} ${AppString.hoursAgo.tr()}';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} ${AppString.minutesAgo.tr()}';
    }
    return AppString.justNow.tr();
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
