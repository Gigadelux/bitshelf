import 'package:flutter/material.dart';

class PopUpStringMenu{
  final Map<String, String> config; // key: label, value: initial value
  final String title;
  final void Function(Map<String, String>) onSubmit;

  const PopUpStringMenu({
    required this.config,
    required this.title,
    required this.onSubmit,
  });
  
  Future<void> popItUp(BuildContext context)async{
    final controllers = <String, TextEditingController>{
      for (var entry in config.entries)
        entry.key: TextEditingController(text: entry.value)
    };
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: controllers.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(labelText: entry.key),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final result = <String, String>{
                  for (var entry in controllers.entries)
                    entry.key: entry.value.text
                };
                onSubmit(result);
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}