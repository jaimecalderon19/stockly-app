import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  final Widget content;

  const BaseBottomSheet({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12.0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: const Color(0XFFD6D6D6),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 26.0),
          content,
        ],
      ),
    );
  }
}

void showBaseBottomSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return BaseBottomSheet(
        content: content,
      );
    },
  );
}