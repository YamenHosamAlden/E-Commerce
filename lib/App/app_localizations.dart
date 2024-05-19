import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Applocalizations {
  final Locale? locale;

  Applocalizations({this.locale});

  static Applocalizations? of(BuildContext context) {
    return Localizations.of<Applocalizations>(context, Applocalizations);
  }

  static const LocalizationsDelegate<Applocalizations> delegate =
      ApplocalizationsDelegate();

  late Map<String, String> localizedStrings;

  Future loadJsonLanguage() async {
    String jsonString = await rootBundle
        .loadString("assets/translations/${locale!.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) => localizedStrings[key] ?? "";
}

class ApplocalizationsDelegate extends LocalizationsDelegate<Applocalizations> {
  const ApplocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<Applocalizations> load(Locale locale) async {
    Applocalizations applocalizations = Applocalizations(locale: locale);
    await applocalizations.loadJsonLanguage();
    return applocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Applocalizations> old) =>
      false;
}

extension Translate on String {
  String tr(BuildContext context) {
    return Applocalizations.of(context)!.translate(this);
  }
}
