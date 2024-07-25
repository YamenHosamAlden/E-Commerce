import 'package:bloc/bloc.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<ChangeLanguage>((event, emit) {
      if (AppSharedPreferences.hasArLang) {
        AppSharedPreferences.removeArLang();
      } else {
        AppSharedPreferences.saveArLang("ar");
      }

      emit(AppState());
    });

    on<ChangeTheme>((event, emit) {
      if (AppSharedPreferences.hasDarkTheme) {
        AppSharedPreferences.removeDarkTheme();
      } else {
        AppSharedPreferences.saveDarkTheme(true);
      }

      emit(AppState());
    });
  }
}
