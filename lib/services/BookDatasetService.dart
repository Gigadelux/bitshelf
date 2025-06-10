// lib/services/book_dataset.dart
import 'package:bitshelf/core/AppConfig.dart';
import 'package:bitshelf/core/BookCRUDStrategy/BookDataStrategy.dart';
import 'package:bitshelf/core/BookCRUDStrategy/BookDeferredDataStrategy.dart';
import 'package:bitshelf/core/CrudOperation.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';
import 'package:flutter/foundation.dart';

class BookDatasetService extends ChangeNotifier { //Observer pattern
  static final BookDatasetService _instance = BookDatasetService._internal();
  factory BookDatasetService() => _instance;
  BookDatasetService._internal();

  final List<Book> _books = [];
  Map<Book, CrudOperation> _pending = {};

  List<Book> get books => List.unmodifiable(_books);
  Map<Book,CrudOperation> get pendingOperations => Map.unmodifiable(_pending); //redundant unmodifiable, Proxy pattern


  void _getPendings(){
    try{
      Map<Book,CrudOperation> pendingOps = (Appconfig().bookDataStrategy as Bookdeferreddatastrategy).pending_edits;
      _pending = pendingOps;
    }catch(e){print("not pending operations, continue...");}
  }

  Future<void> addBook(Book book) async{
    Book.check(book);
    if(_books.contains(book)) throw ArgumentError("Book is already in the dataset");
    Bookdatastrategy gatewayStrategy = Appconfig().bookDataStrategy;
    await gatewayStrategy.add(book);
    _books.add(book);
    _getPendings();
    notifyListeners();
  }

  Future<void> removeBook(Book book) async{
    Book.check(book);
    if(!_books.contains(book)) throw ArgumentError("Book is not in the dataset");
    Bookdatastrategy gatewayStrategy = Appconfig().bookDataStrategy;
    await gatewayStrategy.delete(book);
    _books.remove(book);
    _getPendings();
    notifyListeners();
  }

  Future<void> importBooks() async{
    BookRepository gatewayRepository = Appconfig().bookRepository;
    _books
      ..clear()
      ..addAll(await gatewayRepository.getAll());
    notifyListeners();
  }
  Future<void> updateBook(Book oldBook, Book newBook) async {
    Book.check(newBook);
    Bookdatastrategy gatewayStrategy = Appconfig().bookDataStrategy;
    await gatewayStrategy.update(newBook);
    int index = _books.indexOf(oldBook);
    if (index != -1) {
      _books[index] = newBook;
      _getPendings();
      notifyListeners();
    }
  }
  Future<void> applyChanges() async{
    Bookdatastrategy bookdatastrategy = Appconfig().bookDataStrategy;
    bookdatastrategy.commit();
  }
}