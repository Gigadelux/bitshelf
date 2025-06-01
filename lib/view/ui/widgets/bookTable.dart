import 'package:flutter/material.dart';
import 'package:bitshelf/data/models/Book.dart';

class Booktable extends StatefulWidget {
  final List<Book> books;
  final void Function(Book) onActionPressed;
  const Booktable({super.key, required this.books, required this.onActionPressed});

  @override
  State<Booktable> createState() => _BooktableState();
}

class _BooktableState extends State<Booktable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: const Color.fromARGB(69, 0, 0, 0),blurRadius: 16.5, spreadRadius: 0.2, offset: Offset(0.0, 0.7))
        ],
        borderRadius: BorderRadius.circular(10)
      ),
      child: widget.books.isNotEmpty? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Author')),
            DataColumn(label: Text('ISBN')),
            DataColumn(label: Text('Genre')),
            DataColumn(label: Text('Review')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Action')),
          ],
          rows: widget.books.map((book) => DataRow(
            cells: [
              DataCell(Text(book.id)),
              DataCell(Text(book.title)),
              DataCell(Text(book.author)),
              DataCell(Text(book.codeISBN)),
              DataCell(Text(book.genre)),
              DataCell(Text(book.review.toString())),
              DataCell(Text(book.status)),
              DataCell(
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => widget.onActionPressed(book),
                ),
              ),
            ],
          )).toList(),
        ),
      ):
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text("To visualize books start by adding one", style: TextStyle(fontWeight: FontWeight.w500),),
      )
    );
  }
}