part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SigInEvent extends AuthEvent {
  final String phoneNumber;

  final String password;
  SigInEvent({
    required this.phoneNumber,
    required this.password,
  });
}

class SignUpEvent extends AuthEvent {
  
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

  ChangePasswordEvent( {required this.newPassword,required this.phoneNumber});
}

class DeleteAccountEvent extends AuthEvent {
  final int  playerId;

  DeleteAccountEvent( {required this.playerId});
}

class LogOutEvent extends AuthEvent {}
