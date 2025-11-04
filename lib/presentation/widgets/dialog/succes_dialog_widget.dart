import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockly/presentation/widgets/dialog/base_dialog_widget.dart';

// Dialog to show an error message.
// This dialog is used to show an error message to the user.
Future<void> showSuccessDialog({
  required BuildContext context,
  required String message,
  Function? onPressed,
}) async {
  return showBaseDialog(
    context: context,
    icon: HugeIcons.strokeRoundedCheckmarkCircle02,
    iconColor: const Color(0xFF22BB33),
    text: message,
    primaryButtonText: 'Ok',
    onPrimaryButtonPressed: () {
      Navigator.of(context).pop();
      onPressed?.call();
    },
  );
}