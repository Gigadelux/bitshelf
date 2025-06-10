import 'package:bitshelf/data/models/Book.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> labelsToFilter = Book.empty().toMap().keys.toList();
    labelsToFilter.remove("codeISBN");
    List<Widget> filterFields = [];
    for (var label in labelsToFilter) {
      if (label == "review") {
        filterFields.addAll([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Reviews (from)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Reviews (to)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ]);
      } else {
        filterFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                labelText: label[0].toUpperCase() + label.substring(1),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        );
      }
    }
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Filtering:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ...filterFields
      ],
    );
  }
}