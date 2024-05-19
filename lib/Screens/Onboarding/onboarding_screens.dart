import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Screens/Auth/sign_in_screen.dart';
import 'package:ecommerce/Screens/Onboarding/screen1.dart';
import 'package:ecommerce/Screens/Onboarding/screen2.dart';
import 'package:ecommerce/Screens/Onboarding/screen3.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  @override
  void initState() {
    super.initState();
  }

  static PageController pageController = PageController();

  List<Widget> screens = [
    OnboardingScreen1(
      onPressed: () {
        pageController.nextPage(
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
      },
    ),
    OnboardingScreen2(
      onPressed: () {
        pageController.nextPage(
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
      },
    ),
    const OnboardingScreen3()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: screens,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: screens.length,
                effect: ExpandingDotsEffect(
                  dotColor: Theme.of(context).textTheme.bodyMedium!.color!,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotHeight: 1.h,
                  dotWidth: 2.w,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        await AppSharedPreferences.saveHideOnboarding(true);
                        if (context.mounted) {
                          GeneralRoute.navigatorPushAndRemoveScreensWithContext(
                              context, const SignInScreen());
                        }
                      },
                      child: CustomText(
                        textData: "Skip".tr(context),
                 
                     
                      )),
                ],
              ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        ],
      ),
    );
  }
}
