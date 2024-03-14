part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {
  final String stageTitle;
  final String buttonTitle;
  const ResetPasswordState(this.stageTitle, this.buttonTitle);
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial() : super('Enter your current PIN', 'Next');
}

class ResetPasswordNewPassword extends ResetPasswordState {
  const ResetPasswordNewPassword() : super('Enter your new PIN', 'Confirm');
}

class ResetPasswordConfirmPassword extends ResetPasswordState {
  final String passwordToConfirm;
  const ResetPasswordConfirmPassword(this.passwordToConfirm)
      : super('Re-enter new PIN', 'Done');
}

class ResetPasswordSuccessflly extends ResetPasswordState {
  const ResetPasswordSuccessflly() : super('', '');
}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  const ResetPasswordError(this.message) : super('', '');
}
