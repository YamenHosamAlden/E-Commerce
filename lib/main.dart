import 'package:ecommerce/App/app.dart';
import 'package:ecommerce/Bloc/bloc_observer/BlocObservable.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  
  // Role.init();
  Bloc.observer = BlocObservable();
  print("token is ${AppSharedPreferences.getToken}");
  print("Language is ${AppSharedPreferences.getArLang}");
  // print("Role Id is ${AppSharedPreferences.getRoleId}");
  // print("Team Id is ${AppSharedPreferences.getTeamId}");
  print("Hide Onboarding ${AppSharedPreferences.getHideOnboarding}");

  runApp(const MyApp());
}
