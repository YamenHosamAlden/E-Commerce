import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Screens/Auth/sign_in_screen.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String phoneNumber;
  ChangePasswordScreen({super.key, required this.phoneNumber});

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, title: ''),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
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
                  Expanded(
                    child: CustomText(
                      textData: "Create new password".tr(context),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: CustomTextField(
                  controller: passwordController,
                  prefixIcon: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      child: Image(
                        image: const AssetImage(AppAssets.lockIcon),
                        color: Theme.of(context).primaryColor,
                        width: 5.w,
                        height: 2.h,
                        fit: BoxFit.fill,
                      )),
                  textInputType: TextInputType.visiblePassword,

                  isPassword: true,

                  hintText: "Enter Your Password".tr(context),
                  // validatorMessage: "Please Enter Your Password".tr(context),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              BlocConsumer<AuthBloc, AuthStates>(
                listener: (context, state) {
                  if (state is ChangePasswordErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColors.redColor,
                      duration: const Duration(seconds: 5),
                      content: Text(
                        state.message,
                      ),
                    ));
                  }
                  if (state is ChangePasswordSuccesfulState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColors.greanColor,
                      duration: const Duration(seconds: 5),
                      content: Text(
                        "Edit password Succesfully".tr(context),
                      ),
                    ));
                    GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                        context, const SignInScreen());
                  }
                },
                builder: (context, state) {
                  AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                  return state is! ChangePasswordLoadingState
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authBloc.add(ChangePasswordEvent(
                                    phoneNumber: phoneNumber,
                                    newPassword: passwordController.text));
                              }
                              // GeneralRoute.navigatorPushWithContext(
                              //     context,
                              //     VerificationCodePage(
                              //       countryCode: "+971",
                              //       phone: "502900946",
                              //     ));
                            },
                            textColor: Theme.of(context).primaryColor,
                            buttonText: "Create".tr(context),
                          ),
                        )
                      : const LoadingWidget();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
