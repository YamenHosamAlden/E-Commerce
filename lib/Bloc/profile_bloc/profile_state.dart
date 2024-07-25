part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileLoadingState extends ProfileState {}

final class GetProfileSuccessfulState extends ProfileState {}

final class GetProfileErrorState extends ProfileState {
  final String message;

  GetProfileErrorState({required this.message});
}

class EditProfileLoadingState extends ProfileState {}

class EditProfileSuccessfulState extends ProfileState {}

class EditProfileErrorState extends ProfileState {
  final String message;
  EditProfileErrorState({
    required this.message,
  });
}

class ChangePasswordLoadingState extends ProfileState {}

class ChangePasswordSuccessfulState extends ProfileState {}

class ChangePasswordErrorState extends ProfileState {
  final String message;
  ChangePasswordErrorState({
    required this.message,
  });
}
