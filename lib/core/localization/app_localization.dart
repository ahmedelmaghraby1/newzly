import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newzly/core/localization/languages/arabic.dart';
import 'package:newzly/core/localization/languages/english.dart';

class AppLocalization {
  AppLocalization(this.locale);

  Locale locale;

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': arabic,
    'en': english,
  };

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const List<Locale> supportedLocales = [Locale('ar'), Locale('en')];

  static List<String> languages() => _localizedValues.keys.toList();

  String getString(String text, {Map<String, String>? parameters}) {
    String value = _localizedValues[locale.languageCode]![text] ?? text;

    if (parameters != null) {
      parameters.forEach((key, replacement) {
        value = value.replaceAll('{$key}', replacement);
      });
    }
    return value;
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalization.languages().contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}

extension LocalizationExtension on String {
  String tr(BuildContext context, {Map<String, String>? parameters}) =>
      AppLocalization.of(context).getString(this, parameters: parameters);
}
