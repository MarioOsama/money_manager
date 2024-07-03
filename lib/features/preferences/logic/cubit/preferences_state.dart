part of 'preferences_cubit.dart';

abstract class PreferencesState {
  final String dateFormat;
  final String currency;
  final String language;
  const PreferencesState(this.dateFormat, this.currency, this.language);
}

class PreferencesInitialState extends PreferencesState {
  const PreferencesInitialState() : super('', '', '');
}

class PreferencesLoadedState extends PreferencesState {
  const PreferencesLoadedState(
      super.dateFormat, super.currency, super.language);
}

class PreferencesEditingState extends PreferencesState {
  const PreferencesEditingState(
      super.dateFormat, super.currency, super.language);

  PreferencesEditingState copyWith({
    String? dateFormat,
    String? currency,
    String? language,
  }) {
    return PreferencesEditingState(
      dateFormat ?? this.dateFormat,
      currency ?? this.currency,
      language ?? this.language,
    );
  }
}

class PreferencesSavedState extends PreferencesState {
  const PreferencesSavedState(super.dateFormat, super.currency, super.language);
}

class PreferencesErrorState extends PreferencesState {
  final String message;
  const PreferencesErrorState(this.message) : super('', '', '');
}
