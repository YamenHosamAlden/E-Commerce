import 'package:bloc/bloc.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:meta/meta.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, ThemeChangeState> {
  bool darkTheme = false;
  AppThemeBloc() : super(ThemeChangeState()) {
    on<ToggleThemeEvent>((event, emit) {
      darkTheme = !darkTheme;
      AppSharedPreferences.saveTheme(darkTheme);
      emit(ThemeChangeState());
    });
    on<LoadCurrentThemeEvent>((event, emit) {
      darkTheme = AppSharedPreferences.getTheme;
      emit(ThemeChangeState());
    });
  }
}
