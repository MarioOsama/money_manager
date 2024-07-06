import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/core/routing/routes.dart';
import 'package:money_manager/features/preferences/data/repos/preferences_repo.dart';
import 'package:restart_app/restart_app.dart';

part 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final PreferencesRepo _preferencesRepo;
  PreferencesCubit(this._preferencesRepo)
      : super(const PreferencesInitialState());

  final List<String> dateFormats = <String>[
    'DD/MM/YYYY',
    'D days ago',
  ];

  final List<String> currencies = <String>[
    '\$',
    'Custom',
  ];

  final List<String> languages = <String>[
    'English',
    'العربية',
  ];

  TextEditingController currencyController = TextEditingController();

  void loadUserPreferences() {
    final Map<String, dynamic> userPreferences =
        _preferencesRepo.getUserPreferences();
    emit(PreferencesLoadedState(
      userPreferences[DatabaseConstants.dateFormat],
      userPreferences[DatabaseConstants.currency],
      userPreferences[DatabaseConstants.language],
    ));
    currencyController.text = userPreferences[DatabaseConstants.currency];
  }

  void setUserPreferences(String preference) {
    if (dateFormats.contains(preference)) {
      emit(PreferencesEditingState(preference, state.currency, state.language));
    } else if (currencies.contains(preference)) {
      currencyController.clear();
      emit(PreferencesEditingState(
          state.dateFormat, preference, state.language));
    } else if (languages.contains(preference)) {
      emit(PreferencesEditingState(
          state.dateFormat, state.currency, preference));
    }
  }

  void saveUserPreferences() {
    // Prepare preferences
    final Map<String, dynamic> preferences = {
      DatabaseConstants.currency: state.currency,
      DatabaseConstants.dateFormat: state.dateFormat,
      DatabaseConstants.language: state.language
    };
    if (state.currency != '\$') {
      final bool isCurrency = isCurrencyEntered();
      if (!isCurrency) {
        return;
      }
      preferences[DatabaseConstants.currency] = currencyController.text;
    }

    // Save preferences
    try {
      final String storedLanguage =
          _preferencesRepo.getUserPreferences()[DatabaseConstants.language];
      _preferencesRepo.saveUserPreferences(preferences);
      emit(PreferencesSavedState(
        preferences[DatabaseConstants.dateFormat],
        preferences[DatabaseConstants.currency],
        preferences[DatabaseConstants.language],
      ));
      // Restart the app to apply the new language
      if (storedLanguage != state.language) {
        Restart.restartApp();
      }
    } catch (e) {
      emit(PreferencesErrorState(e.toString()));
    }
  }

  bool isCurrencyEntered() {
    if (currencyController.text.trim().isEmpty) {
      final String currentCurrency = state.currency;
      final String currentDateFormat = state.dateFormat;
      final String language = state.language;

      emit(const PreferencesErrorState('Please enter a currency'));
      emit(PreferencesEditingState(
          currentDateFormat, currentCurrency, language));
      return false;
    } else {
      emit(PreferencesEditingState(
          state.dateFormat, currencyController.text, state.language));
      return true;
    }
  }

  Map<String, List<bool>> getUserPreferences() {
    final Map<String, dynamic> userPreferences =
        _preferencesRepo.getUserPreferences();

    final List<bool> dateFormatSelection = dateFormats
        .map((dateFormat) =>
            dateFormat == userPreferences[DatabaseConstants.dateFormat])
        .toList();

    final List<bool> currencySelection =
        userPreferences[DatabaseConstants.currency] == '\$'
            ? [true, false]
            : [false, true];

    final List<bool> languageSelection = languages
        .map((language) =>
            language == userPreferences[DatabaseConstants.language])
        .toList();

    return {
      'selectedDateFormat': dateFormatSelection,
      'selectedCurrency': currencySelection,
      'selectedLanguage': languageSelection,
    };
  }
}
