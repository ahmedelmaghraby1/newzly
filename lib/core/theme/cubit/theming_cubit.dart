import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'theming_state.dart';

class ThemingCubit extends Cubit<ThemingState> {
  late bool _darkMode;
  ThemingCubit() : super(ThemingStateInitial()) {
    _darkMode = _checkTheme();
  }
  bool get darkMode => _darkMode;
  static ThemingCubit get(BuildContext context) =>
      BlocProvider.of<ThemingCubit>(context);
  bool _checkTheme() {
    Box<dynamic> settingsBox = Hive.box<dynamic>('settings');
    bool theme = settingsBox.get('darkMode', defaultValue: false);
    return theme;
  }

  void setDarkMode(bool theme) {
    _darkMode = theme;
    Box<dynamic> settingsBox = Hive.box<dynamic>('settings');
    settingsBox.put('darkMode', _darkMode);
    emit(ChangeThemeState());
  }
}
