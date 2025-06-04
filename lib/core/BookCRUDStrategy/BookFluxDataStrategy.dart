import 'package:bitshelf/core/BookCRUDStrategy/BookDataStrategy.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';

class Bookfluxdatastrategy extends Bookdatastrategy{
  final BookRepository bookRepository;
  Bookfluxdatastrategy(this.bookRepository);
  @override
  Future<void> add(Book book) => bookRepository.add(book);

  @override
  Future<void> delete(String id) => bookRepository.delete(id);

  @override
  Future<void> update(Book book) => bookRepository.update(book);

  @override
  Future<void> commit() async{} //nothing to commit

}