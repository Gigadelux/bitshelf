import 'package:bitshelf/controllers/BookController.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/view/ui/widgets/desktopToast.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({super.key});

  final List<String> fieldLabels = Book.empty().toMap().keys.toList();
  final Bookcontroller bookcontroller = Bookcontroller();

  @override
  Widget build(BuildContext context) {
    final Map<String, TextEditingController> controllers = {
      for (var label in fieldLabels) label: TextEditingController(),
    };
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
                controller: controllers[label],
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
            onPressed: () async{
              try{
                final Map<String, dynamic> bookMap = {
                  for (var entry in controllers.entries) entry.key: int.tryParse(entry.value.text)?? entry.value.text
                };
                await bookcontroller.addBook(
                  Book.fromMap(bookMap)
                );
                Desktoptoast().showDesktopToast(context, "Added successful");
              }catch(error){
                Desktoptoast().showDesktopToast(context, "Error $error");
              }
              Navigator.pop(context);
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