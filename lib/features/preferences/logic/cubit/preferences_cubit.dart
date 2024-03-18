import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/database/database_constants.dart';
import 'package:money_manager/features/preferences/data/repos/preferences_repo.dart';

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

  TextEditingController currencyController = TextEditingController();

  void loadUserPreferences() {
    final Map<String, dynamic> userPreferences =
        _preferencesRepo.getUserPreferences();
    emit(PreferencesLoadingState(
      userPreferences[DatabaseConstants.dateFormat],
      userPreferences[DatabaseConstants.currency],
    ));
  }

  void setUserPreferences(String preference) {
    if (dateFormats.contains(preference)) {
      emit(PreferencesEditingState(preference, state.currency));
    } else {
      currencyController.clear();
      emit(PreferencesEditingState(state.dateFormat, preference));
    }
  }

  void saveUserPreferences() {
    // Prepare preferences
    final Map<String, dynamic> preferences = {
      DatabaseConstants.currency: state.currency,
      DatabaseConstants.dateFormat: state.dateFormat,
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
      _preferencesRepo.saveUserPreferences(preferences);
      emit(PreferencesSavedState(
        preferences[DatabaseConstants.dateFormat],
        preferences[DatabaseConstants.currency],
      ));
    } catch (e) {
      emit(PreferencesErrorState(e.toString()));
    }
  }

  bool isCurrencyEntered() {
    if (currencyController.text.trim().isEmpty) {
      final String currentCurrency = state.currency;
      final String currentDateFormat = state.dateFormat;
      emit(const PreferencesErrorState('Please enter a currency'));
      emit(PreferencesEditingState(currentDateFormat, currentCurrency));
      return false;
    } else {
      emit(PreferencesEditingState(state.dateFormat, currencyController.text));
      return true;
    }
  }

  Map<String, List<bool>> getUserPreferences() {
    final Map<String, dynamic> userPreferences =
        _preferencesRepo.getUserPreferences();

    final List<bool> dateFormatSelection = dateFormats
        .map((title) => title == userPreferences[DatabaseConstants.dateFormat])
        .toList();

    final List<bool> currencySelection = currencies
        .map((title) => title == userPreferences[DatabaseConstants.currency])
        .toList();

    if (!currencySelection.contains(true)) {
      currencyController.text = userPreferences[DatabaseConstants.currency];
      return {
        'selectedDateFormat': dateFormatSelection,
        'selectedCurrency': [false, true],
      };
    } else {
      return {
        'selectedDateFormat': dateFormatSelection,
        'selectedCurrency': currencySelection,
      };
    }
  }
}
