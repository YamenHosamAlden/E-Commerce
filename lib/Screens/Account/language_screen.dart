import 'package:ecommerce/App/app_localizations.dart';
import 'package:ecommerce/Bloc/app_bloc/app_bloc.dart';
import 'package:ecommerce/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/Widgets/app_bar_widget.dart';
import 'package:ecommerce/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum Lang { english, arabic }

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late Lang? lang;


  @override
  void initState() {
    super.initState();
    if (AppSharedPreferences.hasArLang) {
      lang = Lang.arabic;
    } else {
      lang = Lang.english;
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
            RadioListTile<Lang>(
              title: CustomText(
                textData: 'English',
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              groupValue: lang,
              value: Lang.english,
              onChanged: (newLang) {
                setState(() {
                  lang = newLang;
                      BlocProvider.of<AppBloc>(context).add(ChangeLanguage());
                });
              },
            ),
            RadioListTile<Lang>(
              title: CustomText(
                textData: 'العربية',
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              groupValue: lang,
              value: Lang.arabic,
              onChanged: (Lang? newLang) {
                setState(() {
                  lang = newLang;
                      BlocProvider.of<AppBloc>(context).add(ChangeLanguage());
                });
              },
            ),
          ],
        ));
  }
}
