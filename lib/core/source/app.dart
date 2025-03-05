import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/core/localization/cubit/localization_cubit.dart';
import 'package:newzly/core/theme/cubit/theming_cubit.dart';
import 'package:newzly/core/theme/theming_assets/themes.dart';
import 'package:newzly/features/home/presentation/UI/screens/home_screen.dart';

class Newzly extends StatelessWidget {
  const Newzly({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemingCubit, ThemingState>(
      builder: (context, state) {
        return BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: Size(393, 852),
              child: MaterialApp(
                title: 'Newzly',
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
                supportedLocales: AppLocalization.supportedLocales,
                localizationsDelegates: [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: state.locale,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode:
                    ThemingCubit.get(context).darkMode
                        ? ThemeMode.dark
                        : ThemeMode.light,
              ),
            );
          },
        );
      },
    );
  }
}
