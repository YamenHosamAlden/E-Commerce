part of 'addrees_bloc.dart';

@immutable
sealed class AddreesState {}

final class AddreesInitial extends AddreesState {}

class GetAddreesesErrorState extends AddreesState {
  final String message;
  GetAddreesesErrorState({required this.message});
}

class GetAddreesesLoadingState extends AddreesState {}

class GetAddreesesSuccessfulState extends AddreesState {}

class SetNewAddreesErrorState extends AddreesState {
  final String message;
  SetNewAddreesErrorState({required this.message});
}

class SetNewAddreesLoadingState extends AddreesState {}

class SetNewAddreesSuccessfulState extends AddreesState {}

class DeleteAddreesErrorState extends AddreesState {
  final String message;
  DeleteAddreesErrorState({required this.message});
}

class DeleteAddreesLoadingState extends AddreesState {}

class DeleteAddreesSuccessfulState extends AddreesState {}

class ConfirmOrderErrorState extends AddreesState {
  final String message;
  ConfirmOrderErrorState({required this.message});
}

class ConfirmOrderLoadingState extends AddreesState {}

class ConfirmOrderSuccessfulState extends AddreesState {}