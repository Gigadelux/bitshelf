import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/services/ExporterService.dart';

class Bookcontroller {
  Future<void> load_books()async{
     BookDatasetService().importBooks();
  }
  Future<void> addBook(Book book) async {
    BookDatasetService().addBook(book);
  }

  Future<void> updateBook(Book oldBook, Book newBook) async {
    BookDatasetService().updateBook(oldBook, newBook);
  }

  Future<void> deleteBook(Book book) async {
    BookDatasetService().removeBook(book);
  }
  Future<void> exportBooks(String path) async{
    await ExporterService().export(path);
  }
}