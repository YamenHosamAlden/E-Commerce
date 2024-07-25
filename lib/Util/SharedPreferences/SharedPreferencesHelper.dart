
import 'package:ecommerce/Core/Constants/app_strings.dart';

import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  static SharedPreferencesProvider? sharedPreferencesProvider;
  static init() async {
    sharedPreferencesProvider = await SharedPreferencesProvider.getInstance();
  }

  //token
  static String get getToken =>
      sharedPreferencesProvider!.read(AppStrings.token) ?? '';
  static saveToken(String value) =>
      sharedPreferencesProvider!.save(AppStrings.token, value);
  static bool get hasToken =>
      sharedPreferencesProvider!.contains(AppStrings.token);
  static removeToken() => sharedPreferencesProvider!.remove(AppStrings.token);
 
  //Onboarding
  static bool get getHideOnboarding =>
      sharedPreferencesProvider!.read(AppStrings.firstTimeInApp) ?? false;
  static saveHideOnboarding(bool value) =>
      sharedPreferencesProvider!.save(AppStrings.firstTimeInApp, value);
  static bool get hideOnboarding =>
      sharedPreferencesProvider!.contains(AppStrings.firstTimeInApp);
  static removeHideOnboarding() =>
      sharedPreferencesProvider!.remove(AppStrings.firstTimeInApp);

  //lang
  static String get getArLang =>
      sharedPreferencesProvider!.read(AppStrings.language) ?? "en";
  static saveArLang(String value) =>
      sharedPreferencesProvider!.save(AppStrings.language, value);
  static bool get hasArLang =>
      sharedPreferencesProvider!.contains(AppStrings.language);
  static removeArLang() =>
      sharedPreferencesProvider!.remove(AppStrings.language);
 
  //theme
  static bool get getDarkTheme => sharedPreferencesProvider!.read(AppStrings.theme) ??  false ;
  static saveDarkTheme(bool value) => sharedPreferencesProvider!.save(AppStrings.theme, value);
  static bool get hasDarkTheme => sharedPreferencesProvider!.contains(AppStrings.theme);
  static removeDarkTheme() => sharedPreferencesProvider!.remove(AppStrings.theme);

  static clearSharedPreferences() {
    sharedPreferencesProvider!.clear();
  }
}
