import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Screens/Auth/log_in_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Widgets/custom_button.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.h,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.slaeImage),
                    fit: BoxFit.contain)),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Expanded(
                child: CustomText(
                    textData: "Many offers and great features".tr(context),
                    textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.headlineMedium,
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
                onPressed: () async {
                  await AppSharedPreferences.saveHideOnboarding(true);
                  if (context.mounted) {
                    GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                        context, const LogInScreen());
                  }
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
