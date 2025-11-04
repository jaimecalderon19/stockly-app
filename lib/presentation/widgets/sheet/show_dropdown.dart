import 'package:flutter/material.dart';
import 'package:stockly/presentation/widgets/sheet/base_bottom_sheet.dart';

void showDialogOptions(
  BuildContext context,
   List<Map<String, dynamic>> options,
   Function(Map<String, dynamic>) onOptionSelected,
   {
    String? title,
    Function? onClose,
   }
  ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return PopScope(
        canPop: true,
         onPopInvokedWithResult: (bool didPop, Object? result)  async {
          // Llamar a una función cuando se cierre el BottomSheet
          onClose?.call();
        },
        child: BaseBottomSheet(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              for (final option in options)
                ListTile(
                  title: Text(option['label']),
                  onTap: () {
                    onOptionSelected(option);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}