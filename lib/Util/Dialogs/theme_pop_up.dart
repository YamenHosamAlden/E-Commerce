import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/app_theme_bloc/app_theme_bloc.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

popUpChooseTheme(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        bool value =  BlocProvider.of<AppThemeBloc>(context).darkTheme;
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
                    textData:   "Choose Theme".tr(context),
                      textStyle:  Theme.of(context).textTheme.headlineMedium
                    )),
                const SizedBox(height: 5),
                CheckboxListTile(
                    value: !value,
                    onChanged: (newVal) {
                      newVal =  BlocProvider.of<AppThemeBloc>(context).darkTheme;
                      BlocProvider.of<AppThemeBloc>(context)
                          .add(ToggleThemeEvent());
                    },
                    title:  CustomText(textData: "Dark".tr(context),)),
                CheckboxListTile(
                    value: value,
                    onChanged: (newVal) {
                      newVal = ! BlocProvider.of<AppThemeBloc>(context).darkTheme;
                      BlocProvider.of<AppThemeBloc>(context)
                          .add(ToggleThemeEvent());
                    },
                    title:  CustomText(textData: "Light".tr(context),)),
              ]),
            ));
      });
}
