import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class OnboardingScreen1 extends StatelessWidget {
  final Function onPressed;
  const OnboardingScreen1({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.welcomeImage),
                    fit: BoxFit.contain)),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Expanded(
                child: CustomText(
                    textAlign: TextAlign.center,
                    textData: "Welcome Customer".tr(context),
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                   ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomText(
                    textAlign: TextAlign.center,
                    textData: "We are here for you!".tr(context),
                       textStyle: Theme.of(context).textTheme.bodyMedium,
                   ),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  onPressed();
                },
                buttonText: "Next".tr(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
