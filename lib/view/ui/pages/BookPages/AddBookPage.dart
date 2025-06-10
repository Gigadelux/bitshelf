import 'package:bitshelf/data/models/Book.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({super.key});

  final List<String> fieldLabels = Book.empty().toMap().keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Book',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
        Expanded(
          child: ListView(
            children: [
          ...fieldLabels.map(
            (label) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
              ),
            ),
          ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            color: Colors.blue,
            
            onPressed: () {
          // Add book logic here
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add', style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
          ],
        ),
      ),
      );
  }
}