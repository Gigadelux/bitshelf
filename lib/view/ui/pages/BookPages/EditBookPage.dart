import 'package:bitshelf/controllers/BookController.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/view/ui/widgets/desktopToast.dart';
import 'package:flutter/material.dart';

class EditBookPage extends StatelessWidget {
  final Book book;
  const EditBookPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final Map<String,dynamic> bookMap = book.toMap();
    final List<String> fieldLabels = bookMap.keys.toList();
    List<TextEditingController> controllers= fieldLabels.map((label)=> TextEditingController(text: bookMap[label].toString())).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Book',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Book reference: ${book.title}, by ${book.author}',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            color: Colors.red,
            onPressed: () async{
              try{
                await Bookcontroller().deleteBook(book);
                Desktoptoast().showDesktopToast(context, "Deleted successful!", error: true);
              }catch(e){
                Desktoptoast().showDesktopToast(context, "Error $e", error: true);
              }
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Delete', style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
        ],
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
                    controller: controllers[fieldLabels.indexOf(label)],
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
            color: Colors.yellow[800],
            onPressed: () async{
              try{
                final Map<String, dynamic> newBookMap = {
                  for (int i = 0; i < fieldLabels.length; i++)
                    fieldLabels[i]: int.tryParse(controllers[i].text)??controllers[i].text
                };
                await Bookcontroller().updateBook(book, Book.fromMap(newBookMap));
                Desktoptoast().showDesktopToast(context, "Updated successful");
              }catch(error){
                Desktoptoast().showDesktopToast(context, "Error: $error", error: true);
              }
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Update', style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
          ],
        ),
      ),
      );
  }
}