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
      Map<Book,CrudOperation> pendingOps = Map<Book, CrudOperation>.from(
        (Appconfig().bookDataStrategy as Bookdeferreddatastrategy).pending_edits
      );
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
    try{
      (Appconfig().bookDataStrategy as Bookdeferreddatastrategy).clear();
      _pending.clear();
    }catch(e){}
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
    int index = _books.indexWhere((b) => b.codeISBN == oldBook.codeISBN);
    if (index != -1) {
      _books[index] = newBook;
      _getPendings();
      notifyListeners();
    }
  }
  Future<void> applyChanges() async{
    Bookdatastrategy bookdatastrategy = Appconfig().bookDataStrategy;
    bookdatastrategy.commit();
    _pending.clear();
  }

  Future<void> sortBooks(String field,bool ascending) async{ //inefficient but scalable
    int compare(Book a, Book b){
      Map aMap = a.toMap();
      Map bMap = b.toMap();
      for(String key in aMap.keys.toList()){
        if(key==field) return aMap[key].compareTo(bMap[key]);
      }
      return 0;
    }
    if(field == "none"){
      await importBooks();
      if(!ascending){
        List<Book> tmp = [..._books.reversed];
        _books.clear();
        _books.addAll(tmp);
        print(_books);
      }
    }else{
      _books.sort((a,b)=> compare(a, b)*(ascending? 1:-1));
    }
    notifyListeners();
  }
}