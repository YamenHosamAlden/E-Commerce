import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, BottomNavigationBarState> {

  int currentIndex = 0;
  MainBloc() : super(BottomNavigationBarState()) {

    on<SelectBottomNavigationBarItem>((event, emit) {
      currentIndex = event.index;
      emit(BottomNavigationBarState());
    });
  }
}
