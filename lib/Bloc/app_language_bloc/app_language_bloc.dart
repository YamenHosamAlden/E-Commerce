import 'package:bloc/bloc.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, ChangeLanguageState> {
  AppLanguageBloc()
      : super(ChangeLanguageState(locale: Locale(AppSharedPreferences.getArLang))) {
    on<AppLanguageEvent>((event, emit) async {
      if (event is InitLanguage) {
        emit(ChangeLanguageState(locale: Locale(AppSharedPreferences.getArLang)));
      }

      if (event is ChangeLanguageToAr  ) {
        await AppSharedPreferences.saveArLang('ar');
        emit(ChangeLanguageState(locale: Locale(AppSharedPreferences.getArLang)));
      }
      if (event is ChangeLanguageToEn) {
        await AppSharedPreferences.removeArLang();
        emit(ChangeLanguageState(locale: Locale(AppSharedPreferences.getArLang)));
      }
    });
  }
}
