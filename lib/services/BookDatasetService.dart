// lib/services/book_dataset.dart
import 'package:bitshelf/data/models/Book.dart';
import 'package:flutter/foundation.dart';

class BookDatasetService extends ChangeNotifier { //Observer pattern
  static final BookDatasetService _instance = BookDatasetService._internal();
  factory BookDatasetService() => _instance;
  BookDatasetService._internal();

  final List<Book> _books = [];

  List<Book> get books => List.unmodifiable(_books);

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void removeBook(Book book) {
    _books.remove(book);
    notifyListeners();
  }

  void setBooks(List<Book> books) {
    _books
      ..clear()
      ..addAll(books);
    notifyListeners();
  }
}
