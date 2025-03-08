import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newzly/core/UI/widgets/shadow_container.dart';
import 'package:newzly/core/localization/app_localization.dart';
import 'package:newzly/core/theme/cubit/theming_cubit.dart';
import 'package:newzly/core/utils/hive_helper.dart';
import 'package:newzly/features/settings/presentation/UI/widgets/settings_component_title.dart';

class DarkModeComponent extends StatelessWidget {
  const DarkModeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsComponentTitle(title: 'theme'),
        SizedBox(height: 10.h),
        ValueListenableBuilder(
          valueListenable: HiveHelper.settingsListenable(),
          builder: (context, Box<dynamic> box, _) {
            return ShadowedContainer(
              padding: EdgeInsets.zero,
              borderColor: Theme.of(context).colorScheme.tertiary,
              child: SwitchListTile.adaptive(
                title: Text(
                  'darkMode'.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: ThemingCubit.get(context).darkMode,
                onChanged: (value) {
                  ThemingCubit.get(context).setDarkMode(value);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
