import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/app_bloc/app_bloc.dart';
import 'package:ecommerce/Bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce/Bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/Bloc/categories_bloc/categories_bloc.dart';
import 'package:ecommerce/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:ecommerce/Bloc/main_bloc/main_bloc.dart';
import 'package:ecommerce/Bloc/notification_bloc/notification_bloc.dart';
import 'package:ecommerce/Bloc/profile_bloc/profile_bloc.dart';
import 'package:ecommerce/Bloc/start_app_bloc/start_app_bloc.dart';
import 'package:ecommerce/Core/theme/dark_theme.dart';
import 'package:ecommerce/Core/theme/light_theme.dart';
import 'package:ecommerce/Screens/Splash/splash_screen.dart';
import 'package:ecommerce/Util/GeneralRoute.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Util/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AppBloc()),
            BlocProvider(
              create: (context) => ConnectivityBloc(),
            ),
            BlocProvider(
              create: (context) => MainBloc(),
            ),
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(),
            ),
            BlocProvider(
              create: (context) => CategoriesBloc(),
            ),
            BlocProvider(
              create: (context) => StartAppBloc(),
            ),
            BlocProvider(
              create: (context) => CartBloc(),
            ),
            BlocProvider(
              create: (context) => NotificationBloc(),
            ),
          ],
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return MaterialApp(
                color: Theme.of(context).primaryColor,
                title: Environment.appName,
                themeMode: AppSharedPreferences.hasDarkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                theme: light,
                darkTheme: dark,
                debugShowCheckedModeBanner: false,
                locale: Locale(AppSharedPreferences.getArLang),
                supportedLocales: const [Locale('en', 'US'), Locale('ar')],
                localizationsDelegates: const [
                  Applocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                navigatorKey: GeneralRoute.navigatorKey,
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                home: const SplashScreen(),
              );
            },
          )),
    );
  }
}
