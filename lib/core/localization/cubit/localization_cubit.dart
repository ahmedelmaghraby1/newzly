import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newzly/core/localization/app_localization.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  late String _language;
  LocalizationCubit() : super(LocalizationInit()) {
    _language = _getLanguage();
    emit(LocalizationChange(Locale(_language)));
  }
  get language => _language;

  static LocalizationCubit get(context) =>
      BlocProvider.of<LocalizationCubit>(context);
  void changeLanguage(String locale) {
    if (locale == _language) {
    } else {
      // _language = locale;
      switch (locale) {
        case 'ar':
          changeLanguageToArabic();
        case 'en':
          changeLanguageToEnglish();

        default:
      }
    }
  }

  void changeLanguageToArabic() {
    _language = 'ar';
    _changeLanguage(_language);
    emit(LocalizationChange(AppLocalization.supportedLocales.first));
  }

  void changeLanguageToEnglish() {
    _language = 'en';

    _changeLanguage(_language);
    emit(LocalizationChange(AppLocalization.supportedLocales.last));
  }

  String _getLanguage() {
    Box<dynamic> settingsBox = Hive.box('settings');
    String locale = settingsBox.get('locale', defaultValue: 'en');
    return locale;
  }

  void _changeLanguage(String locale) {
    Box<dynamic> settingsBox = Hive.box<dynamic>('settings');
    settingsBox.put('locale', locale);
  }
}
