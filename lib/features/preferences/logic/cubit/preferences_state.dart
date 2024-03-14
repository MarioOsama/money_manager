part of 'preferences_cubit.dart';

abstract class PreferencesState {
  final String dateFormat;
  final String currency;
  const PreferencesState(this.dateFormat, this.currency);
}

class PreferencesInitialState extends PreferencesState {
  const PreferencesInitialState() : super('', '');
}

class PreferencesLoadingState extends PreferencesState {
  const PreferencesLoadingState(super.dateFormat, super.currency);
}

class PreferencesEditingState extends PreferencesState {
  const PreferencesEditingState(super.dateFormat, super.currency);

  PreferencesEditingState copyWith({
    String? dateFormat,
    String? currency,
  }) {
    return PreferencesEditingState(
      dateFormat ?? this.dateFormat,
      currency ?? this.currency,
    );
  }
}

class PreferencesSavedState extends PreferencesState {
  const PreferencesSavedState(super.dateFormat, super.currency);
}

class PreferencesErrorState extends PreferencesState {
  final String message;
  const PreferencesErrorState(this.message) : super('', '');
}
