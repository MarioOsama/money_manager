import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/features/verification/data/repos/verification_repo.dart';
import 'package:money_manager/features/verification/logic/cubit/verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationRepo _verificationRepo;

  VerificationCubit(this._verificationRepo) : super(VerificationInitial());

  bool isInConfirmationMode = false;
  VerificationState previousState = VerificationInitial();

  @override
  void onChange(Change<VerificationState> change) {
    super.onChange(change);
    if (change.currentState is VerificationCreatePin) {
      previousState = change.currentState;
    }
  }

  bool get isUserExist => _verificationRepo.userExistence();

  void emitUserState() {
    if (isUserExist) {
      emit(const VerificationVerifyPin(verificationPin: ''));
    } else {
      isInConfirmationMode
          ? emit(const VerificationConfirmPin(confirmationPin: ''))
          : emit(const VerificationCreatePin(pin: ''));
    }
  }

  void updatePin(String newPin) {
    switch (state.runtimeType) {
      case VerificationCreatePin:
        emit(VerificationCreatePin(pin: newPin));
        break;
      case VerificationConfirmPin:
        emit(VerificationConfirmPin(confirmationPin: newPin));
        break;
      case VerificationVerifyPin:
        emit(VerificationVerifyPin(verificationPin: newPin));
        break;
      default:
        break;
    }
  }

  void onDoneTap() {
    final pinCode = state.getValue;

    if (pinCode.length < 4) {
      emit(const VerificationErrorState(
        error: "PIN must be 4 digits.",
        errorCode: 1,
      ));
      emitUserState();
      return;
    }

    if (state is VerificationVerifyPin) {
      handleVerifyPin(pinCode);
    } else {
      handleConfirmationMode();
    }
  }

  void handleVerifyPin(String pinCode) {
    final isPinVerified = isVerifiedPin(pinCode);

    if (isPinVerified) {
      emit(VerificationSuccess(pinCode: pinCode));
    } else {
      emit(const VerificationErrorState(
        error: "Incorrect PIN. Please try again.",
        errorCode: 0,
      ));
      emitUserState();
    }
  }

  void handleConfirmationMode() {
    if (isInConfirmationMode) {
      confirmPin();
    } else {
      toggleConfirmationMode();
    }
  }

  bool isVerifiedPin(String pin) =>
      _verificationRepo.isVerifiedUserPinCode(pin);

  void toggleConfirmationMode() {
    isInConfirmationMode = !isInConfirmationMode;
    emitUserState();
  }

  void confirmPin() {
    final pinCode = previousState.getValue;
    final confirmationCode = state.getValue;

    if (pinCode == confirmationCode) {
      emit(
        VerificationSuccess(
          pinCode: confirmationCode,
        ),
      );
      storePinCode(state.getValue);
    } else {
      emit(
        const VerificationErrorState(
          error: "Unmatched PIN. Please try again.",
          errorCode: 2,
        ),
      );
      isInConfirmationMode = false;
      emitUserState();
    }
  }

  void storePinCode(String pin) => _verificationRepo.storeUserPinCode(pin);
}
