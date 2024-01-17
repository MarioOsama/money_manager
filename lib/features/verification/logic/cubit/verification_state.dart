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

class VerificationVerifyPin extends VerificationState {}

class VerificationSuccess extends VerificationState {}

class VerificationErrorState extends VerificationState {
  final String error;

  const VerificationErrorState({required this.error});

  @override
  String get getValue => error;
}
