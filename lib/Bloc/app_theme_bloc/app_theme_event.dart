part of 'app_theme_bloc.dart';

@immutable
sealed class AppThemeEvent {}
class ToggleThemeEvent extends AppThemeEvent {}

class LoadCurrentThemeEvent extends AppThemeEvent {}