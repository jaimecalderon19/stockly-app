import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? iconColor;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;

  const BaseDialog({
    super.key,
    required this.text,
    this.icon,
    this.iconColor,
    this.primaryButtonText = 'OK',
    this.secondaryButtonText,
    required this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Close icon in the top-right corner (optional)
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          
          // Icon (if provided)
          if (icon != null) ...[
            Icon(
              icon,
              size: 50,
              color: iconColor ?? Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
          ],
          
          // Text
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 24),
          
          // Buttons
          Row(
            mainAxisAlignment: secondaryButtonText != null 
                ? MainAxisAlignment.spaceBetween 
                : MainAxisAlignment.center,
            children: [
              // Secondary button (if provided)
              if (secondaryButtonText != null)
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: onSecondaryButtonPressed ?? () {
                      Navigator.of(context).pop();
                    },
                    child: Text(secondaryButtonText!),
                  ),
                ),
              
              if (secondaryButtonText != null)
                const SizedBox(width: 16),
              
              // Primary button (default OK button)
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D5FEF), // Purple color similar to image
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: onPrimaryButtonPressed,
                  child: Text(primaryButtonText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Función para mostrar el diálogo fácilmente desde cualquier parte de la app
Future<void> showBaseDialog({
  required BuildContext context,
  required String text,
  IconData? icon,
  Color? iconColor,
  String primaryButtonText = 'OK',
  String? secondaryButtonText,
  VoidCallback? onPrimaryButtonPressed,
  VoidCallback? onSecondaryButtonPressed,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BaseDialog(
        text: text,
        icon: icon,
        iconColor: iconColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryButtonPressed: onPrimaryButtonPressed ?? () {
          Navigator.of(context).pop();
        },
        onSecondaryButtonPressed: onSecondaryButtonPressed,
      );
    },
  );
}
