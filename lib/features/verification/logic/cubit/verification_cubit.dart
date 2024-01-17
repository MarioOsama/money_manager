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

  bool get isUserExist {
    return _verificationRepo.userExistence();
  }

  void emitUserState() {
    if (isUserExist) {
      emit(VerificationVerifyPin());
    }
    if (isInConfirmationMode) {
      emit(const VerificationConfirmPin(confirmationPin: ''));
    } else {
      emit(const VerificationCreatePin(pin: ''));
    }
  }

  void updatePin(String newPin) {
    if (isInConfirmationMode) {
      emit(VerificationConfirmPin(confirmationPin: newPin));
    } else {
      emit(VerificationCreatePin(pin: newPin));
    }
  }

  void onDoneTap() {
    if (isInConfirmationMode) {
      confirmPin();
    } else {
      toggleConfirmationMode();
    }
  }

  void toggleConfirmationMode() {
    isInConfirmationMode = !isInConfirmationMode;
    emitUserState();
  }

  void confirmPin() {
    final pinCode = previousState.getValue;
    final confirmationCode = state.getValue;
    if (pinCode == confirmationCode) {
      emit(VerificationSuccess());
    } else {
      emit(const VerificationErrorState(
          error: "Unmatched PIN. Please try again."));
      isInConfirmationMode = false;
      emitUserState();
    }
  }

  // // Get verification code
  // String get verificationCode {
  //   final code = ['1234', '4321'];
  //   print(code[Random().nextInt(2)]);
  //   return code[Random().nextInt(2)];
  // }

  // // Method to trigger the verification of an existing PIN
  // void verifyPin(String pin) {
  //   // Logic to check if the entered PIN matches the stored PIN
  //   // You should implement your own logic to retrieve and compare the PIN securely
  //   // For example, you can use a secure storage library.
  //   if (/* PIN verification logic */) {
  //     emit(VerificationSuccess());
  //   } else {
  //     emit(VerificationError("Invalid PIN. Please try again."));
  //   }
  // }

  // // Method to trigger the creation of a new PIN
  // void createPin(bool isInConfirmationMode) {
  //   emit(VerificationCreatePin(isInConfirmationMode: isInConfirmationMode));
  //   if (checkPinLegnth()) {
  //     emit(VerificationSuccess());
  //   } else {
  //     emit(const VerificationErrorState(
  //         error: "Invalid PIN. Please enter 4 digits."));
  //   }
  //   // Logic to store the newly created PIN
  //   // You should implement your own logic to store the PIN securely
  //   // For example, you can use a secure storage library.
  // }

  // bool isNewUser = false;

  // States emitting

  // void emitVerificationCode(String code) {
  //   if (checkCodeLegnth()) {
  //     isInConfirmationMode = true;
  //     emit(code);
  //   } else {
  //     isInConfirmationMode = false;
  //     emit(null);
  //   }
  // }

  // bool checkPinLegnth() {
  //   return pin.length == 4;
  // }
}
