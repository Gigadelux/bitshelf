import 'package:bitshelf/data/models/Book.dart';

abstract class BookRepository {
  Map<String, dynamic> _config;
  BookRepository(this._config);

  Map<String, dynamic> get config => _config;
  set config(Map<String, dynamic> value) => _config = value;

  Future<List<Book>> getAll();
  Future<Book?> getById(String id);
  Future<void> add(Book book);
  Future<void> update(Book book);
  Future<void> delete(String id);
  Future<void> export(List<Book> toExport);
}