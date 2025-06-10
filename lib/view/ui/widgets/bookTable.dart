import 'package:flutter/material.dart';
import 'package:bitshelf/data/models/Book.dart';

class Booktable extends StatelessWidget {
  final List<Book> books;
  final void Function(Book) onActionPressed;

  const Booktable({super.key, required this.books, required this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(69, 0, 0, 0),
              blurRadius: 16.5,
              spreadRadius: 0.2,
              offset: Offset(0.0, 0.7),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: books.isNotEmpty
            ? SingleChildScrollView(
                child: PaginatedDataTable(
                  header: const Text("Book List"),
                  rowsPerPage: 5,
                  columns: const [
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Author')),
                    DataColumn(label: Text('ISBN')),
                    DataColumn(label: Text('Genre')),
                    DataColumn(label: Text('Review')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Edit')),
                  ],
                  source: BookDataSource(books, onActionPressed),
                ),
              )
            : const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "To visualize books start by adding one",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
      ),
    );
  }
}

class BookDataSource extends DataTableSource {
  final List<Book> books;
  final void Function(Book) onActionPressed;

  BookDataSource(this.books, this.onActionPressed);

  @override
  DataRow getRow(int index) {
    final book = books[index];
    return DataRow(cells: [
      DataCell(Text(book.title)),
      DataCell(Text(book.author)),
      DataCell(Text(book.codeISBN)),
      DataCell(Text(book.genre)),
      DataCell(Text(book.review.toString())),
      DataCell(Text(book.status)),
      DataCell(
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => onActionPressed(book),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => books.length;

  @override
  int get selectedRowCount => 0;
}
