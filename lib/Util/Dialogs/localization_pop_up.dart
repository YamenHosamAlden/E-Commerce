import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/app_bloc/app_bloc.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

popUpChooseLocale(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        bool value = AppSharedPreferences.hasArLang;
        return AlertDialog(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w)),
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CustomText(
                      textData: "Choose your language".tr(context),
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                    )),
                const SizedBox(height: 5),
                RadioListTile<bool>(
                  title: CustomText(
                    textData: 'English',
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  groupValue: false,
                  value: value,
                  onChanged: (newVal) {
                    BlocProvider.of<AppBloc>(context).add(ChangeLanguage());
                  },
                ),
                RadioListTile<bool>(
                  title: CustomText(
                    textData: 'العربية',
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  groupValue: false,
                  value: !value,
                  onChanged: (newVal) {
                    BlocProvider.of<AppBloc>(context).add(ChangeLanguage());
                  },
                ),
              ]),
            ));
      });
}
