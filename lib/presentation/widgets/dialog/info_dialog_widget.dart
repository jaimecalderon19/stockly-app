import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:stockly/presentation/widgets/dialog/base_dialog_widget.dart';

// Dialog to show an error message.
// This dialog is used to show an error message to the user.
Future<void> showInfoDialog({
  required BuildContext context,
  required String message,
}) async {
  return showBaseDialog(
    context: context,
    icon: HugeIcons.strokeRoundedInformationCircle,
    iconColor: const Color(0xFF00BBF9),
    text: message,
    primaryButtonText: 'Ok',
    onPrimaryButtonPressed: () {
      Navigator.of(context).pop();
    },
  );
}