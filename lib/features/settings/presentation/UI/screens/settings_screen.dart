import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/features/settings/presentation/UI/widgets/app_language_component.dart';
import 'package:newzly/features/settings/presentation/UI/widgets/dark_mode_component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr(context))),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  DarkModeComponent(),
                  SizedBox(height: 20.h),
                  AppLanguageComponent(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
