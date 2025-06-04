// lib/services/book_dataset.dart
import 'package:bitshelf/core/AppConfig.dart';
import 'package:bitshelf/core/BookCRUDStrategy/BookDataStrategy.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';
import 'package:flutter/foundation.dart';

class BookDatasetService extends ChangeNotifier { //Observer pattern
  static final BookDatasetService _instance = BookDatasetService._internal();
  factory BookDatasetService() => _instance;
  BookDatasetService._internal();

  final List<Book> _books = [];

  List<Book> get books => List.unmodifiable(_books);

  Future<void> addBook(Book book) async{
    Bookdatastrategy gatewayStrategy = Appconfig().bookDataStrategy;
    await gatewayStrategy.add(book);
    _books.add(book);
    notifyListeners();
  }

  Future<void> removeBook(Book book) async{
    Bookdatastrategy gatewayStrategy = Appconfig().bookDataStrategy;
    await gatewayStrategy.delete(book.id);
    _books.remove(book);
    notifyListeners();
  }

  Future<void> importBooks() async{
    BookRepository gatewayRepository = Appconfig().bookRepository;
    _books
      ..clear()
      ..addAll(await gatewayRepository.getAll());
    notifyListeners();
  }
  Future<void> applyChanges() async{
    Bookdatastrategy bookdatastrategy = Appconfig().bookDataStrategy;
    bookdatastrategy.commit();
  }
}
