import 'package:bitshelf/core/AppConfig.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';

class Bookcontroller {
  Future<void> load_books()async{
     BookDatasetService().setBooks(await Appconfig().bookRepository.getAll());
  }
}