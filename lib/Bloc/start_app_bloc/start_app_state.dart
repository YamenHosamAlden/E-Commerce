part of 'start_app_bloc.dart';

@immutable
sealed class StartAppState {}

final class StartAppInitial extends StartAppState {}

class StartAppLoadingState extends StartAppState {}

class StartAppSuccessfulState extends StartAppState {}

class StartAppErrorState extends StartAppState {
  final String message;
  StartAppErrorState({required this.message});
}
