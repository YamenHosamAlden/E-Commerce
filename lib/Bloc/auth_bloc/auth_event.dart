part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;

  final String password;
  LoginEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthEvent {
  final SignUpModel signUpModel;

  SignUpEvent({required this.signUpModel});
}

class VerifySmsCodeEvent extends AuthEvent {
  final String code;

  VerifySmsCodeEvent({required this.code});
}

class SendCodeEvent extends AuthEvent {
  final String phone;

  SendCodeEvent({
    required this.phone,
  });
}

class CheckPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;

  CheckPhoneNumberEvent({required this.phoneNumber});
}

class ChangePasswordEvent extends AuthEvent {
  final String phoneNumber;
  final String newPassword;

  ChangePasswordEvent({required this.newPassword, required this.phoneNumber});
}

class DeleteAccountEvent extends AuthEvent {
  final int playerId;

  DeleteAccountEvent({required this.playerId});
}

class LogOutEvent extends AuthEvent {}
