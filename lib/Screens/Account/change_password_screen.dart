import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/profile_bloc/profile_bloc.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/functions.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text_falid.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, title: "Security"),
        body: Form(
          key: formKey,
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ChangePasswordErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    errorSnackBar(context, message: state.message));
              }
              if (state is ChangePasswordSuccessfulState) {
                ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
                    context,
                    message: "Change Password Successfully"));
                BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: oldPasswordController,
                                textInputType: TextInputType.visiblePassword,
                                isPassword: true,
                                hintText: "Old Password",
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Your Old Password";
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomTextField(
                                controller: newPasswordController,
                                textInputType: TextInputType.visiblePassword,
                                isPassword: true,
                                hintText: "New Password",
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Your New Password";
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomTextField(
                                controller: confirmPasswordController,
                                textInputType: TextInputType.visiblePassword,
                                isPassword: true,
                                hintText: "Confirm Password",
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Your Confirm Password";
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide
                        .color,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            textColor: Theme.of(context).primaryColor,
                            buttonColor: Theme.of(context).cardColor,
                            onPressed: () {
                              GeneralRoute.navigatorPobWithContext(context);
                            },
                            buttonText: "Cancel".tr(context),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Expanded(
                          child: state is EditProfileLoadingState
                              ? Center(
                                  child: SizedBox(
                                      height: 8.h,
                                      width: 16.w,
                                      child: const LoadingWidget()),
                                )
                              : CustomButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<ProfileBloc>(context).add(
                                          ChangePasswordEvent(
                                              oldPassword:
                                                  oldPasswordController.text,
                                              newPassword:
                                                  newPasswordController.text,
                                              confirmPassword:
                                                  confirmPasswordController
                                                      .text));
                                    }
                                  },
                                  buttonText: "Save",
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              );
            },
          ),
        ));
  }
}
