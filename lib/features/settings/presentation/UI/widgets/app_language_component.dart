import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newzly/core/UI/widgets/shadow_container.dart';
import 'package:newzly/core/localization/cubit/localization_cubit.dart';
import 'package:newzly/core/utils/hive_helper.dart';
import 'package:newzly/features/settings/presentation/UI/widgets/settings_component_title.dart';

class AppLanguageComponent extends StatelessWidget {
  const AppLanguageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsComponentTitle(title: 'appLanguage'),
        SizedBox(height: 10.h),
        ValueListenableBuilder(
          valueListenable: HiveHelper.settingsListenable(),
          builder: (context, Box<dynamic> box, _) {
            return ShadowedContainer(
              borderColor: Theme.of(context).colorScheme.tertiary,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('English'),
                      Spacer(),
                      Radio<String>.adaptive(
                        value: 'en',
                        groupValue: LocalizationCubit.get(context).language,
                        onChanged: (value) {
                          LocalizationCubit.get(
                            context,
                          ).changeLanguageToEnglish();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('العربية'),
                      Spacer(),
                      Radio<String>(
                        value: 'ar',
                        groupValue: LocalizationCubit.get(context).language,
                        onChanged: (value) {
                          LocalizationCubit.get(
                            context,
                          ).changeLanguageToArabic();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
