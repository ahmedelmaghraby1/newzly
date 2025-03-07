import 'package:flutter/material.dart';
import 'package:newzly/core/localization/app_localization.dart';

void showErrorSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(_snackBar(context: context, message: message));
}

SnackBar _snackBar({required BuildContext context, required String message}) =>
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(message.tr(context)),
    );
