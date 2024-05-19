part of 'app_language_bloc.dart';

@immutable
abstract class AppLanguageEvent {}
class InitLanguage extends AppLanguageEvent{}
class ChangeLanguageToAr extends AppLanguageEvent{}
class ChangeLanguageToEn extends AppLanguageEvent{}
