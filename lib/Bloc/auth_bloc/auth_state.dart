part of 'auth_bloc.dart';

@immutable
abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class SignUpLoadingState extends AuthStates {}

class SignUpSuccessfulState extends AuthStates {}

class SignUpErrorState extends AuthStates {
  final String message;
  SignUpErrorState({required this.message});
}

class LogInLoadingState extends AuthStates {}

class LogInSuccessfulState extends AuthStates {}

class LogInErrorState extends AuthStates {
  final String message;
  LogInErrorState({required this.message});
}

class FillSigUpLoadingState extends AuthStates {}

class FillSigUpSuccessfulState extends AuthStates {}

class FillSigUpErrorState extends AuthStates {
  final String message;
  FillSigUpErrorState({required this.message});
}

class LogOutLoadingState extends AuthStates {}

class LogOutSuccessfulState extends AuthStates {}

class LogOutErrorState extends AuthStates {
  final String message;
  LogOutErrorState({required this.message});
}

class VerifySmsLoadingState extends AuthStates {}

class VerifySmsSuccessfulState extends AuthStates {}

class VerifySmsErrorState extends AuthStates {
  final String message;
  VerifySmsErrorState({required this.message});
}

class DeleteAccountLoadingState extends AuthStates {}

class DeleteAccountSuccessfulState extends AuthStates {}

class DeleteAccountErrorState extends AuthStates {
  final String message;
  DeleteAccountErrorState({required this.message});
}

class CheckPhoneNumberLoadingState extends AuthStates {}

class CheckPhoneNumberSuccessfulState extends AuthStates {}

class CheckPhoneNumberErrorState extends AuthStates {
  final String message;
  CheckPhoneNumberErrorState({required this.message});
}

class ChangePasswordLoadingState extends AuthStates {}

class ChangePasswordSuccessfulState extends AuthStates {}

class ChangePasswordErrorState extends AuthStates {
  final String message;
  ChangePasswordErrorState({required this.message});
}

class FirebaseAuthErrorState extends AuthStates {
  final String message;
  FirebaseAuthErrorState({required this.message});
}
