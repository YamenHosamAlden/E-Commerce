import 'dart:async';

import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Screens/Auth/ChangePassword/change_password_screen.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/error_message_widget.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_verification_code/flutter_verification_code.dart';

import 'package:sizer/sizer.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String phone;

  const VerificationCodeScreen({required this.phone, super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late AuthBloc authBloc;
  int second = 60;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(SendCodeEvent(phone: widget.phone));
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (second == 0) {
        timer.cancel();
      } else {
        setState(() {
          second--;
        });
      }
    });
  }

  @override
  build(BuildContext context) {
    // print("what is the  ${widget.countryCode} and ${widget.phone} ");

    return Scaffold(
      appBar: appBarWidget(context, title: "Verification Code".tr(context)),
      body: BlocConsumer<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state is VerifySmsSuccesfulState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.greanColor,
              duration: const Duration(seconds: 5),
              content: Text(
                "Verification Code Successfully".tr(context),
              ),
            ));
            GeneralRoute.navigatorPushWithContext(
                context,
                ChangePasswordScreen(
                  phoneNumber: widget.phone,
                ));
          }
          if (state is VerifySmsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message,
              ),
            ));
          }
        },
        builder: (context, state) {
          if (state is VerifySmsLoadingState) {
            return const LoadingWidget();
          }
          if (state is FirebaseAuthErrorState) {
            return ErrorMessageWidget(
                message: state.message,
                onPressed: () {
                  GeneralRoute.navigatorPobWithContext(context);
                });
          }
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                  height: 30.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppAssets.logoImage),
                          fit: BoxFit.contain)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      textData: "Verify Code".tr(context),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomText(
                        textData:
                            "Enter the the code we just sent you on your phone"
                                .tr(context),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                VerificationCode(
                  fullBorder: true,
                  textStyle: const TextStyle(color: AppColors.blackColor),
                  keyboardType: TextInputType.number,
                  underlineColor: AppColors.textFieldColor,
                  underlineUnfocusedColor: AppColors.textFieldColor,
                  autofocus: true,
                  length: 6,
                  cursorColor: AppColors.blackColor,
                  margin: const EdgeInsets.all(12),
                  onCompleted: (String value) {
                    //  GeneralRoute.navigatorPushWithContext(
                    // context,
                    // ChangePasswordScreen(
                    //   phoneNumber:phone ,

                    // ));
                    authBloc.add(VerifySmsCodeEvent(code: value));
                  },
                  onEditing: (bool value) {},
                ),
                second == 0
                    ? TextButton(
                        onPressed: () {
                          second = 60;
                          startTimer();
                          authBloc.add(SendCodeEvent(phone: widget.phone));
                        },
                        child: CustomText(
                          textData: "Resend Code".tr(context),
                        ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            textData: "${"Resend Code".tr(context)} : $second",
                          ),
                        ],
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
