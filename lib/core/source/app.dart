import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newzly/core/injection/injector.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/core/localization/cubit/localization_cubit.dart';
import 'package:newzly/core/theme/cubit/theming_cubit.dart';
import 'package:newzly/core/theme/theming_assets/themes.dart';

class Newzly extends StatelessWidget {
  const Newzly({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationCubit>(
          create: (context) => getIt<LocalizationCubit>(),
        ),
        BlocProvider<ThemingCubit>(create: (context) => getIt<ThemingCubit>()),
      ],
      child: BlocBuilder<ThemingCubit, ThemingState>(
        builder: (context, state) {
          return BlocBuilder<LocalizationCubit, LocalizationState>(
            builder: (context, state) {
              return ScreenUtilInit(
                designSize: Size(393, 852),
                child: MaterialApp.router(
                  title: 'Newzly',
                  debugShowCheckedModeBanner: false,
                  routerConfig: goRouter,
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
      ),
    );
  }
}
