import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/app_bloc/app_bloc.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum ThemeMode { light, dark }

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  late ThemeMode? themeMode;

  @override
  void initState() {
    super.initState();
    if (AppSharedPreferences.hasDarkTheme) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(context, title: "Language".tr(context)),
        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          shrinkWrap: true,
          children: [
            RadioListTile<ThemeMode>(
              title: CustomText(
                textData: "Light".tr(context),
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              groupValue: themeMode,
              value: ThemeMode.light,
              onChanged: (newTheme) {
                setState(() {
                  themeMode = newTheme;
                   BlocProvider.of<AppBloc>(context).add(ChangeTheme());
                  
                });
              },
            ),
            RadioListTile<ThemeMode>(
              title: CustomText(
                textData: "Dark".tr(context),
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              groupValue: themeMode,
              value: ThemeMode.dark,
              onChanged: (newTheme) {
                setState(() {
                  themeMode = newTheme;
                  BlocProvider.of<AppBloc>(context).add(ChangeTheme());
              
                });
              },
            ),
          ],
        ));
  }
}
