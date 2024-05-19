part of 'auth_bloc.dart';

@immutable
abstract class AuthStates {}

class AuthInitial extends AuthStates {}


class SignUpLoadingState extends AuthStates {}

class SignUpSuccesfulState extends AuthStates {}

class SignUpErrorState extends AuthStates {
  final String message;
  SignUpErrorState({required this.message});
}

class SiginLoadingState extends AuthStates {}

class SiginSuccesfulState extends AuthStates {}

class SiginErrorState extends AuthStates {
  final String message;
  SiginErrorState({required this.message});
}

class FillSigUpLoadingState extends AuthStates {}

class FillSigUpSuccesfulState extends AuthStates {}

class FillSigUpErrorState extends AuthStates {
  final String message;
  FillSigUpErrorState({required this.message});
}
class LogOutLoadingState extends AuthStates {}

class LogOutSuccesfulState extends AuthStates {}

class LogOutErrorState extends AuthStates {
  final String message;
  LogOutErrorState({required this.message});
}

class VerifySmsLoadingState extends AuthStates {}

class VerifySmsSuccesfulState extends AuthStates {}

class VerifySmsErrorState extends AuthStates {
  final String message;
  VerifySmsErrorState({required this.message});
}


class DeleteAccountLoadingState extends AuthStates {}
class DeleteAccountSuccesfulState extends AuthStates {}


class DeleteAccountErrorState extends AuthStates {
  final String message;
  DeleteAccountErrorState({required this.message});
}
class CheckPhoneNumberLoadingState extends AuthStates {}
class CheckPhoneNumberSuccesfulState extends AuthStates {}


class CheckPhoneNumberErrorState extends AuthStates {
  final String message;
  CheckPhoneNumberErrorState({required this.message});
}

class ChangePasswordLoadingState extends AuthStates {}
class ChangePasswordSuccesfulState extends AuthStates {}


class ChangePasswordErrorState extends AuthStates {
  final String message;
  ChangePasswordErrorState({required this.message});
}


class FirebaseAuthErrorState extends AuthStates {
  final String message;
  FirebaseAuthErrorState({required this.message});
}