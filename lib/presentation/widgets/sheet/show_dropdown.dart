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
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return ListTile(
                      title: Text(option['label']),
                      onTap: () {
                        onOptionSelected(option);
                        Navigator.of(context).pop();
                      },
                    );
                  },
              )),
            ],
          ),
        ),
      );
    },
  );
}