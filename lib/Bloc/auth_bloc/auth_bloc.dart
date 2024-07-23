import 'package:bloc/bloc.dart';
import 'package:ecommerce/Data/Models/auth_model.dart';
import 'package:ecommerce/Data/Repository/auth_repository.dart';
import 'package:ecommerce/Services/Helper/api_result.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  AuthRepository authRepository = AuthRepository();
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LogInLoadingState());

      ApiResult apiResult = await authRepository.logIn(
        email: event.email,
        password: event.password,
      );

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        if (apiResult.response!.data['code'] == 401) {
          emit(LogInErrorState(message: apiResult.response!.data['message']));
        } else {
          AppSharedPreferences.saveToken(apiResult.response!.data["token"]);
          emit(LogInSuccessfulState());
        }
      } else {
        emit(LogInErrorState(message: apiResult.error));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());

      ApiResult apiResult =
          await authRepository.signUp(signUpModel: event.signUpModel);

      if (apiResult.response != null && apiResult.response!.statusCode == 201) {
        AppSharedPreferences.saveToken(apiResult.response!.data["token"]);
        emit(SignUpSuccessfulState());
      } else {
        emit(SignUpErrorState(message: apiResult.error));
      }
    });

    on<LogOutEvent>((event, emit) async {
      emit(LogOutLoadingState());

      ApiResult apiResult = await authRepository.logOut();

      if (apiResult.response != null && apiResult.response!.statusCode == 200) {
        emit(LogOutSuccessfulState());
      } else {
        emit(LogOutErrorState(message: apiResult.error));
      }
    });

    on<VerifySmsCodeEvent>((event, emit) async {
      // emit(VerifySmsLoadingState());
      // try {
      //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
      //       verificationId: verificationId!, smsCode: event.code);
      //   await FirebaseAuth.instance.signInWithCredential(credential);
      //   emit(VerifySmsSuccessfulState());
      // } catch (error) {
      //   if (error is FirebaseAuthException) {
      //     emit(VerifySmsErrorState(message: "The code is invalid"));
      //   } else {
      //     emit(VerifySmsErrorState(message: "Something went wrong"));
      //   }
      // }
    });

    on<SendCodeEvent>((event, emit) async {
      // FirebaseAuth auth = FirebaseAuth.instance;
      // try {
      //   await auth.verifyPhoneNumber(
      //     phoneNumber: event.phone,
      //     // phoneNumber: "+971 123456789",
      //     timeout: const Duration(seconds: 60),
      //     codeAutoRetrievalTimeout: (String verificationId) {
      //       this.verificationId = verificationId;
      //     },
      //     codeSent: (String verificationId, int? resendToken) async {
      //       this.verificationId = verificationId;
      //     },
      //     verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      //     verificationFailed: (FirebaseAuthException error) {
      //       if (error.code == 'invalid-phone-number') {
      //         Fluttertoast.showToast(
      //             msg: "Invalid phone number",
      //             toastLength: Toast.LENGTH_SHORT,
      //             gravity: ToastGravity.TOP,
      //             timeInSecForIosWeb: 10,
      //             backgroundColor: AppColors.redColor,
      //             textColor: Theme.of(context).primaryColor,
      //             fontSize: 16.0);
      //       }
      //       if (error.code == 'too-many-requests') {
      //         Fluttertoast.showToast(
      //             msg: 'Try again after a few hours',
      //             toastLength: Toast.LENGTH_SHORT,
      //             gravity: ToastGravity.TOP,
      //             timeInSecForIosWeb: 10,
      //             backgroundColor: AppColors.redColor,
      //             textColor: Theme.of(context).primaryColor,
      //             fontSize: 16.0);
      //       } else {
      //         Fluttertoast.showToast(
      //             msg: error.code,
      //             toastLength: Toast.LENGTH_SHORT,
      //             gravity: ToastGravity.TOP,
      //             timeInSecForIosWeb: 10,
      //             backgroundColor: AppColors.redColor,
      //             textColor: Theme.of(context).primaryColor,
      //             fontSize: 16.0);
      //       }
      //     },
      //   );

      //   // emit(SendCodeSuccessfulState());
      // } catch (error) {
      //   emit(FirebaseAuthErrorState(message: error.toString()));
      // }
    });

    on<CheckPhoneNumberEvent>((event, emit) async {
      // emit(CheckPhoneNumberLoadingState());

      // ApiResult apiResult =
      //     await authRepository.checkPhone(phoneNumber: event.phoneNumber);

      // if (apiResult.response != null && apiResult.response!.statusCode == 200) {
      //   emit(CheckPhoneNumberSuccessfulState());
      // } else {
      //   emit(CheckPhoneNumberErrorState(message: apiResult.error));
      // }
    });

    on<ChangePasswordEvent>((event, emit) async {
      // emit(ChangePasswordLoadingState());

      // ApiResult apiResult = await authRepository.changePassword(
      //     phoneNumber: event.phoneNumber, newPassword: event.newPassword);

      // if (apiResult.response != null && apiResult.response!.statusCode == 200) {
      //   emit(ChangePasswordSuccessfulState());
      // } else {
      //   emit(ChangePasswordErrorState(message: apiResult.error));
      // }
    });

    on<DeleteAccountEvent>((event, emit) async {
      // emit(DeleteAccountLoadingState());

      // ApiResult apiResult = await authRepository.deleteAccount(
      //   playerId: event.playerId,
      // );

      // if (apiResult.response != null && apiResult.response!.statusCode == 200) {
      //   await AppSharedPreferences.clearSharedPreferences();

      //   await AppSharedPreferences.init();
      //   emit(DeleteAccountSuccessfulState());
      // } else {
      //   emit(DeleteAccountErrorState(message: apiResult.error));
      // }
    });
  }
}
