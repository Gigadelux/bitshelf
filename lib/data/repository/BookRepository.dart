
import 'package:bitshelf/data/models/Book.dart';

abstract class BookRepository {
  BookRepository();

  Future<List<Book>> getAll();

}