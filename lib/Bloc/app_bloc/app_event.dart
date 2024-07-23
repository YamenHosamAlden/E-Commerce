part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}



class ChangeLanguage extends AppEvent {}

class ChangeTheme extends AppEvent {}
