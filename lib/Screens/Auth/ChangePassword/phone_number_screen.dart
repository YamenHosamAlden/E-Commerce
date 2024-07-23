import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, title: "Check phone number".tr(context)),
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
                        image: AssetImage(AppAssets.splashImage),
                        fit: BoxFit.contain)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    textData: "Forgot password?".tr(context),
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
                          "Enter your phone, we will send you a verification code."
                              .tr(context),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                height: 4.h,
              ),
              BlocConsumer<AuthBloc, AuthStates>(
                listener: (context, state) {
                  if (state is CheckPhoneNumberErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColors.redColor,
                      duration: const Duration(seconds: 5),
                      content: Text(
                        state.message,
                      ),
                    ));
                  }
                  if (state is CheckPhoneNumberSuccessfulState) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   backgroundColor: AppColors.greanColor,
                    //   duration: const Duration(seconds: 5),
                    //   content: Text(
                    //     "SignIn Successful".tr(context),
                    //   ),
                    // ));
                    // GeneralRoute.navigatorPushWithContext(
                    //     context,
                    //     VerificationCodeScreen(
                    //         phone:
                    //             "+${country?.phoneCode ?? 971} ${phoneController.text}"));
                  }
                },
                builder: (context, state) {
                  return state is! CheckPhoneNumberLoadingState
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authBloc.add(CheckPhoneNumberEvent(
                                  phoneNumber:
                                      "+${971} ${phoneController.text}",
                                ));
                              }
                            },
                            textColor: Theme.of(context).primaryColor,
                            buttonText: "Send".tr(context),
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
