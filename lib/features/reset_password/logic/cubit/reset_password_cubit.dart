import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/features/reset_password/data/repos/reset_password_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo _resetPasswordRepo;
  ResetPasswordCubit(this._resetPasswordRepo)
      : super(const ResetPasswordInitial());

  TextEditingController passwordController = TextEditingController();

  bool passwordValidation() {
    if (passwordController.text.trim().isEmpty ||
        passwordController.text.length < 4) {
      final stateBeforeError = state;
      emit(const ResetPasswordError('Please enter a 4-digit PIN'));
      emit(stateBeforeError);
      return false;
    } else {
      return true;
    }
  }

  bool checkCurrentPassword(String password) {
    final bool isValid = passwordValidation();
    if (!isValid) {
      return false;
    } else {
      final bool isCorrectPassword =
          _resetPasswordRepo.checkCurrentPassword(password);
      if (isCorrectPassword) {
        emit(const ResetPasswordNewPassword());
        return true;
      } else {
        emit(const ResetPasswordError('Incorrect PIN'));
        emit(const ResetPasswordInitial());
        return false;
      }
    }
  }

  void toNewPasswordState() {
    final String password = passwordController.text;
    final bool isPasswordCorrect = checkCurrentPassword(password);
    if (isPasswordCorrect) {
      emit(const ResetPasswordNewPassword());
    }
    passwordController.clear();
  }

  void toConfirmPasswordState() {
    final bool isValid = passwordValidation();
    if (isValid) {
      final String password = passwordController.text;
      emit(ResetPasswordConfirmPassword(password));
    }
    passwordController.clear();
  }

  void resetPassword() {
    final bool isValid = passwordValidation();
    if (isValid) {
      final String password = passwordController.text;
      final String passwordToMatch =
          (state as ResetPasswordConfirmPassword).passwordToConfirm;
      if (password == passwordToMatch) {
        emit(const ResetPasswordSuccessflly());
        _resetPasswordRepo.resetPassword(password);
      } else {
        emit(const ResetPasswordError('PINs do not match'));
        emit(const ResetPasswordNewPassword());
      }
    }
    passwordController.clear();
  }
}
