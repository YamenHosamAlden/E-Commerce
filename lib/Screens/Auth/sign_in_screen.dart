import 'package:country_picker/country_picker.dart';
import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Util/Dialogs/dialog_loading.dart';
import 'package:ecommerce/Util/Dialogs/localization_pop_up.dart';
import 'package:ecommerce/Screens/Auth/ChangePassword/phone_number_screen.dart';
import 'package:ecommerce/Screens/Auth/sign_up_screen.dart';
import 'package:ecommerce/Screens/Main/main_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_country_picker_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  Country? country;
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      popUpChooseLocale(context);
                    },
                    icon: Image.asset(
                      AppAssets.langIcon,
                      height: 5.h,
                      width: 10.w,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              // Container(
              //   height: 30.h,
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage(AppAssets.logoImage),
              //           fit: BoxFit.contain)),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    textData: "Hi, Welcome Customer!".tr(context),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    textData: "Hope you're doing fine.".tr(context),
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomCountryPickerWidget(
                  hintSearchText: "Search for country".tr(context),
                  hintText: "Enter Your Phone".tr(context),
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please Enter Your Phone".tr(context);
                    }
                    if (input.length == 9) {
                      return "The phone number must be 9 numbers";
                    }
                    return null;
                  },
                  country: country,
                  onSelect: (newCountry) {
                    country = newCountry;
                  },
                  textEditingController: phoneController),
              SizedBox(
                height: 2.h,
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
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please Enter Your Password".tr(context);
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              BlocListener<AuthBloc, AuthStates>(
                listener: (context, state) {
                  if (state is SiginLoadingState) {
                    showLoaderDialog(context);
                  }
                  if (state is SiginErrorState) {
                    GeneralRoute.navigatorPobWithContext(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColors.redColor,
                      duration: const Duration(seconds: 5),
                      content: Text(
                        state.message,
                      ),
                    ));
                  }
                  if (state is SiginSuccesfulState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColors.greanColor,
                      duration: const Duration(seconds: 5),
                      content: Text(
                        "SignIn Succesful".tr(context),
                      ),
                    ));
                    GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                        context, const MainScreen());
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: CustomButton(
                    // buttonColor: Theme.of(context).primaryColor,
                    // textColor: Theme.of(context).textTheme.labelSmall!.color,
                    onPressed: () {
                      // if (formKey.currentState!.validate()) {
                      GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                          context, const MainScreen());
                      // authBloc.add(SigInEvent(
                      //   phoneNumber:
                      //       "+${country?.phoneCode ?? 971}${phoneController.text}",
                      //   password: passwordController.text,
                      // ));
                      // }
                    },
                    buttonText: "Sign In".tr(context),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                    child: Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )),
                  CustomText(
                    textData: "Or".tr(context),
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                    child: Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        GeneralRoute.navigatorPushWithContext(
                            context, const PhoneNumberScreen());
                      },
                      child: CustomText(
                        textData: "Forgot password?".tr(context),
                        textStyle: Theme.of(context).textTheme.labelSmall,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    textData: "Don’t have an account yet?".tr(context),
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        GeneralRoute.navigatorPushWithContext(
                            context, const SignUpScreen());
                      },
                      child: CustomText(
                        textData: "Sign up".tr(context),
                        textStyle: Theme.of(context).textTheme.labelSmall,
                      ))
                ],
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
