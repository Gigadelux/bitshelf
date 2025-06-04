
import 'package:bitshelf/data/models/Book.dart';

abstract class BookRepository {
  BookRepository();

  Future<List<Book>> getAll();
  Future<Book?> getById(String id);
  Future<void> add(Book book);
  Future<void> update(Book book);
  Future<void> delete(String id);
  Future<void> export(List<Book> toExport);
}