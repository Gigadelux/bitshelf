import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';

abstract class Bookdatastrategy {
  late BookRepository _bookRepository;
  BookRepository get repository => _bookRepository;
  set repository(BookRepository repo) => _bookRepository = repo;

  Future<void> add(Book book);
  Future<void> update(Book book);
  Future<void> delete(Book book);
  Future<void> commit(); //Only deferredStrategy
}