import 'package:flutter/material.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil(String routeName, RoutePredicate predicate,
      {Object? arguments}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() {
    return Navigator.of(this).pop();
  }
}

extension Message on BuildContext {
  void showSnackBar(
      {String? message, Color? color, TextStyle? textStyle, Widget? child}) {
    assert(
        (message != null && child == null) ||
            (message == null && child != null),
        'Either message or child should be provided, but not both.');

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: child ??
            Text(
              message ?? '',
              style: textStyle ?? TextStyles.f18WhiteMedium,
            ),
        backgroundColor: color ?? AppColors.primaryDarkColor,
      ),
    );
  }

  void clearSnackBar() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }
}
