import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Core/Constants/app_colors.dart';
import 'package:ecommerce/Data/Models/auth_model.dart';
import 'package:ecommerce/Util/Dialogs/dialog_loading.dart';
import 'package:ecommerce/Util/Dialogs/localization_pop_up.dart';
import 'package:ecommerce/Screens/Main/main_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
        body: BlocListener<AuthBloc, AuthStates>(
            listener: (context, state) {
              if (state is SignUpLoadingState) {
                showLoaderDialog(context);
              }
              if (state is SignUpErrorState) {
                GeneralRoute.navigatorPobWithContext(context);

                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
                  context,
                  message: state.message,
                ));
              }
              if (state is SignUpSuccessfulState) {
                ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                  context,
                  message: "SignUp Successful".tr(context),
                ));

                // GeneralRoute.navigatorPobWithContext(context);
                GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                    context, const MainScreen());
              }
            },
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              GeneralRoute.navigatorPobWithContext(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 8.w,
                            )),
                        IconButton(
                          onPressed: () {
                            popUpChooseLocale(context);
                          },
                          icon: Image(
                            image: const AssetImage(AppAssets.langIcon),
                            height: 5.h,
                            width: 10.w,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: ListView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        children: [
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
                                textData: "Create Account".tr(context),
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: CustomTextField(
                              controller: usernameController,
                              prefixIcon: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 2.h),
                                  child: Image(
                                    image:
                                        const AssetImage(AppAssets.profileIcon),
                                    color: Theme.of(context).primaryColor,
                                    width: 5.w,
                                    height: 2.h,
                                    fit: BoxFit.fill,
                                  )),
                              textInputType: TextInputType.name,
                              hintText: "Enter Your Username".tr(context),
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return "Please Enter Your Username"
                                      .tr(context);
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: firstNameController,
                                    textInputType: TextInputType.name,
                                    hintText:
                                        "Enter Your First Name".tr(context),
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return "Please Enter Your First Name"
                                            .tr(context);
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Expanded(
                                  child: CustomTextField(
                                    controller: lastNameController,
                                    textInputType: TextInputType.name,
                                    hintText:
                                        "Enter Your Last Name".tr(context),
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return "Please Enter Your Last Name"
                                            .tr(context);
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: CustomTextField(
                              controller: emailController,
                              prefixIcon: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 2.h),
                                  child: Image(
                                    image: const AssetImage(AppAssets.smsIcon),
                                    color: Theme.of(context).primaryColor,
                                    width: 5.w,
                                    height: 2.h,
                                    fit: BoxFit.fill,
                                  )),
                              textInputType: TextInputType.emailAddress,
                              hintText: "Enter Your Email".tr(context),
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return "Please Enter Your Email".tr(context);
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: CustomTextField(
                              hintText: "Enter Your Phone".tr(context),
                              controller: phoneController,
                              prefixIcon: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 2.h),
                                  child: Image(
                                    image:
                                        const AssetImage(AppAssets.phoneIcon),
                                    color: Theme.of(context).primaryColor,
                                    width: 5.w,
                                    height: 2.h,
                                    fit: BoxFit.fill,
                                  )),
                              textInputType: TextInputType.phone,
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return "Please Enter Your Phone".tr(context);
                                }
                                if (input.length == 9) {
                                  return "The phone number must be 9 numbers";
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: CustomTextField(
                              controller: passwordController,
                              prefixIcon: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 2.h),
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
                              // validatorMessage:
                              //     "Please Enter Your Password".tr(context),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),

                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.w),
                          //   child: CustomTextField(
                          //     controller: confirmPasswordController,
                          //     prefixIconImage: AppAssets.lockIcon,
                          //     textInputType: TextInputType.visiblePassword,
                          //     isValidator: true,
                          //     isPassword: true,
                          //
                          //     hintText: "Enter Your Confirm Password",
                          //     validatorMessage: "Please Enter Your Confirm Password",
                          //   ),
                          // ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: CustomButton(
                              onPressed: () {
                                SignUpModel signUpModel = SignUpModel(
                                    username: usernameController.text,
                                    fullName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                                if (formKey.currentState!.validate()) {
                                  authBloc.add(
                                      SignUpEvent(signUpModel: signUpModel));
                                }
                              },
                              textColor: AppColors.textFieldColor,
                              buttonText: "Create Account".tr(context),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.5.w),
                                child: Divider(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              )),
                              CustomText(
                                textData: "Or".tr(context),
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.5.w),
                                child: Divider(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                textData:
                                    "Do you have an account ?".tr(context),
                                textStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                              TextButton(
                                  onPressed: () {
                                    GeneralRoute.navigatorPobWithContext(
                                        context);
                                  },
                                  child: CustomText(
                                    textData: "Sign In".tr(context),
                                    textStyle:
                                        Theme.of(context).textTheme.labelSmall,
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
                ],
              ),
            )));
  }
}
