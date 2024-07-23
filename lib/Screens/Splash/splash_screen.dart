import 'dart:async';

import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:ecommerce/Core/Constants/app_assets.dart';
import 'package:ecommerce/Screens/Auth/log_in_screen.dart';
import 'package:ecommerce/Screens/Main/main_screen.dart';
import 'package:ecommerce/Screens/Onboarding/onboarding_screens.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Util/notificaton.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission();
     getFcmToken();

    // requestLocationPermission();

    FirebaseMessaging.onBackgroundMessage(
        NotificatonHandler.firebaseMessagingBackgroundHandler);
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (AppSharedPreferences.hasToken) {
        GeneralRoute.navigatorPushAndRemoveScreensWithContext(
            context, const MainScreen());
      } else {
        if (AppSharedPreferences.hideOnboarding) {
          GeneralRoute.navigatorPushAndRemoveScreensWithContext(
              context, const LogInScreen());
        } else {
          GeneralRoute.navigatorPushAndRemoveScreensWithContext(
              context, const OnboardingScreens());
        }
      }
    });
  }

  void getFcmToken() async {
    NotificatonHandler.fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcm token is  ${NotificatonHandler.fcmToken}");
  }

  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (!status.isGranted) {
      requestLocationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<ConnectivityBloc, ConnectedState>(
        listener: (context, state) {
          if (state.message == "Connecting To Wifi") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
          if (state.message == "Connecting To Mobile Data") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
          if (state.message == "Lost Internet Connection") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message.tr(context),
              ),
            ));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.splashImage,
              height: 15.h,
              width: 30.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  textData: "Welcome Customer".tr(context),
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
