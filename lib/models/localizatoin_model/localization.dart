import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/resources/image_assets.dart';

class AppLocalization {
  final Locale locale;
  static late Locale currentLocale;
  AppLocalization({required this.locale});

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  late Map<String, String> _localizationValues;
  Future loadJson() async {
    String jsonStringValues = await rootBundle.loadString(
        "${AppAssets.localizationsPath}${locale.languageCode}.json");
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizationValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
    if (kDebugMode) {
      print(_localizationValues.keys);
    }
  }

  String getTranslatedValues(String key) {
    return _localizationValues[key]!;
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();
  static const List<String> _list = ['en', 'ar'];
  @override
  bool isSupported(Locale locale) {
    return _list.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale: locale);
    await appLocalization.loadJson();
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
