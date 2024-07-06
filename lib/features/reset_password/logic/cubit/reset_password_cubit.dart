import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/helpers/app_string.dart';
import 'package:money_manager/features/reset_password/data/repos/reset_password_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo _resetPasswordRepo;
  ResetPasswordCubit(this._resetPasswordRepo) : super(ResetPasswordInitial());

  TextEditingController passwordController = TextEditingController();

  bool passwordValidation() {
    if (passwordController.text.trim().isEmpty ||
        passwordController.text.length < 4) {
      final stateBeforeError = state;
      emit(ResetPasswordError(AppString.incompletePIN.tr()));
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
        emit(ResetPasswordNewPassword());
        return true;
      } else {
        emit(ResetPasswordError(AppString.incorrectPIN.tr()));
        emit(ResetPasswordInitial());
        return false;
      }
    }
  }

  void toNewPasswordState() {
    final String password = passwordController.text;
    final bool isPasswordCorrect = checkCurrentPassword(password);
    if (isPasswordCorrect) {
      emit(ResetPasswordNewPassword());
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
        emit(ResetPasswordError(AppString.pinNotMatch.tr()));
        emit(ResetPasswordNewPassword());
      }
    }
    passwordController.clear();
  }
}
