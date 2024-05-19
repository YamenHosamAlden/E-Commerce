part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}



class SelectBottomNavigationBarItem extends MainEvent {
 final int index;
  SelectBottomNavigationBarItem({required this.index});
}
