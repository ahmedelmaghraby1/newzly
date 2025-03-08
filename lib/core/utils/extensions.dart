import 'package:flutter/material.dart';
import 'package:newzly/core/localization/app_localization.dart';

extension DateFormatter on String {
  String timeAgo(BuildContext context) {
    final DateTime? date = DateTime.tryParse(this);
    if (date == null) {
      return 'now'.tr(context);
    } else {
      final Duration duration = DateTime.now().difference(date);
      if (duration.inSeconds < 60) {
        return 'moment_ago'.tr(context);
      } else if (duration.inMinutes < 60) {
        return 'minutes_ago'.tr(
          context,
          parameters: {'count': '${duration.inMinutes}'},
        );
      } else if (duration.inHours < 24) {
        return 'hours_ago'.tr(
          context,
          parameters: {'count': '${duration.inHours}'},
        );
      } else if (duration.inDays < 7) {
        return 'days_ago'.tr(
          context,
          parameters: {'count': '${duration.inDays}'},
        );
      } else if (duration.inDays < 30) {
        return 'weeks_ago'.tr(
          context,
          parameters: {'count': '${duration.inDays ~/ 7}'},
        );
      } else if (duration.inDays < 365) {
        return 'months_ago'.tr(
          context,
          parameters: {'count': '${duration.inDays ~/ 30}'},
        );
      } else {
        return 'years_ago'.tr(
          context,
          parameters: {'count': '${duration.inDays ~/ 365}'},
        );
      }
    }
  }
}
