// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}



class EditProfileEvent extends ProfileEvent {}


class ChangePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
