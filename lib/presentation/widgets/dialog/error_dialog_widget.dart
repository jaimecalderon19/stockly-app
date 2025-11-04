import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockly/presentation/widgets/dialog/base_dialog_widget.dart';

// Dialog to show an error message.
// This dialog is used to show an error message to the user.
Future<void> showErrorDialog({
  required BuildContext context,
  required Exception error,
}) async {
  return showBaseDialog(
    context: context,
    icon: HugeIcons.strokeRoundedCancelCircle,
    iconColor: const Color(0xFFE53935),
    text: error.toString(),
    primaryButtonText: 'Ok',
    onPrimaryButtonPressed: () {
      Navigator.of(context).pop();
    },
  );
}