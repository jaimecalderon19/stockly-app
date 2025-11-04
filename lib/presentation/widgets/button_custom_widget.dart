import 'package:flutter/material.dart';
import 'package:stockly/core/const.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isOutline;
  final bool isLoading;
  final bool isRed;

  const ButtonCustom({
    super.key,
    required this.onPressed,
    required this.text,
    this.isOutline = false,
    this.isLoading = false,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = isOutline
        ? OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(
              color: isRed ? Colors.red : kPrimaryColor, 
              width: 1.5
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: isRed ? Colors.red : kPrimaryColor,
          );

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isOutline 
                    ? (isRed ? Colors.red : kPrimaryColor)
                    : Colors.white,
                ),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: isOutline 
                  ? (isRed ? Colors.red : Colors.black) 
                  : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}