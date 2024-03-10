part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {
  const ResetPasswordState();
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class ResetPasswordCurrentPassword extends ResetPasswordState {
  const ResetPasswordCurrentPassword();
}

class ResetPasswordNewPassword extends ResetPasswordState {
  const ResetPasswordNewPassword();
}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  const ResetPasswordError(this.message);
}
