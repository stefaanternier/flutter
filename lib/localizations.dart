import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);


  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings  = new Map();


  void recursiveMapAnalysis(prefix, jsonMap) {
    jsonMap.map((key, value) {
      if (value.runtimeType == String) {
        _localizedStrings[prefix +"."+ key] = value;

      } else {
        recursiveMapAnalysis(prefix+"."+key, value);
      }
      return  MapEntry(key, "-");
    });
  }

  Future<bool> load() async {
    String jsonString =
    await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    jsonMap.map((key, value) {
      if (value.runtimeType == String) {
        _localizedStrings[key] = value;
      } else {
        recursiveMapAnalysis(key, value);
      }
      return  MapEntry(key, "-");
    });
//    print(_localizedStrings);
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    //print("trans_${key}_");
    if (_localizedStrings == null) return 'null';
    if (_localizedStrings[key] == null) return key;
    return _localizedStrings[key] ?? 'todo';
  }
}


class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return true;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
