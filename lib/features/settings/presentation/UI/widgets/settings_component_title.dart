import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newzly/core/localization/app_localization.dart';

class SettingsComponentTitle extends StatelessWidget {
  final String title;
  const SettingsComponentTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 15.w),
          child: Text(
            title.tr(context),
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
        ),
      ],
    );
  }
}
