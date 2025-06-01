import 'package:bitshelf/core/AppConfig.dart';
import 'package:bitshelf/data/models/Book.dart';

class Bookcontroller {
  Future<List<Book>> load_books(){
    return Appconfig().bookRepository.getAll() as Future<List<Book>>;
  }
}