import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/UI/features/queue/assignement/radio_assignement.dart';
import 'package:sola/presentation/UI/widgets/modal_object.dart';

class SingleSelectRadio extends StatelessWidget {
  const SingleSelectRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioAssignmentProvider>(
      builder: (context, provider, child) {
        List<ModalObject> items = provider.objectInit;
        ModalObject? selectedItem = provider.selectedItem;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) {
            return RadioListTile<ModalObject>(
              title: Text(item.lib, style: const TextStyle(fontSize: 16)),
              value: item,
              groupValue: selectedItem,
              onChanged: (newValue) {
                if (newValue != null) {
                  provider.setObjectIni(newValue);
                }
              },
            );
          }).toList(),
        );
      },
    );
  }
}
