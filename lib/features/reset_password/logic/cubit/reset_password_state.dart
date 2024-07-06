part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {
  final String stageTitle;
  final String buttonTitle;
  const ResetPasswordState(this.stageTitle, this.buttonTitle);
}

class ResetPasswordInitial extends ResetPasswordState {
  ResetPasswordInitial()
      : super(AppString.enterYourCurrentPIN.tr(), AppString.next.tr());
}

class ResetPasswordNewPassword extends ResetPasswordState {
  ResetPasswordNewPassword()
      : super(AppString.enterNewPIN.tr(), AppString.confirm.tr());
}

class ResetPasswordConfirmPassword extends ResetPasswordState {
  final String passwordToConfirm;
  ResetPasswordConfirmPassword(this.passwordToConfirm)
      : super(AppString.reEnterYourNewPIN.tr(), AppString.done.tr());
}

class ResetPasswordSuccessflly extends ResetPasswordState {
  const ResetPasswordSuccessflly() : super('', '');
}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  const ResetPasswordError(this.message) : super('', '');
}
