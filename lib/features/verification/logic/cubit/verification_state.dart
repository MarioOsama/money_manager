import 'package:flutter/material.dart';

@immutable
abstract class VerificationState {
  const VerificationState();

  get getValue => null;
}

class VerificationInitial extends VerificationState {}

class VerificationCreatePin extends VerificationState {
  final String pin;

  const VerificationCreatePin({required this.pin});

  @override
  String get getValue => pin;
}

class VerificationConfirmPin extends VerificationState {
  final String confirmationPin;

  const VerificationConfirmPin({required this.confirmationPin});

  @override
  String get getValue => confirmationPin;
}

class VerificationVerifyPin extends VerificationState {
  final String verificationPin;

  const VerificationVerifyPin({required this.verificationPin});

  @override
  String get getValue => verificationPin;
}

class VerificationSuccess extends VerificationState {
  final String pinCode;
  const VerificationSuccess({required this.pinCode});

  @override
  String get getValue => pinCode;
}

class VerificationErrorState extends VerificationState {
  final String error;
  final int errorCode;

  const VerificationErrorState({required this.error, required this.errorCode});

  @override
  String get getValue => error;

  int get getErrorCode => errorCode;
}
