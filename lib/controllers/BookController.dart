import 'package:bitshelf/core/AppConfig.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';

class Bookcontroller {
  Future<void> load_books()async{
     BookDatasetService().importBooks();
  }
  Future<void> addBook(Book book) async {
  }

  Future<void> updateBook(Book book) async {
  }

  Future<void> deleteBook(String id) async {
  }

  Future<Book?> getBookById(String id) async {
    return null;
  
  }
}