import 'package:bitshelf/data/repository/BookRepository.dart';
import 'package:bitshelf/data/gateway/BookFakeGateway.dart';

class Appconfig { //State pattern
  static final Appconfig _instance = Appconfig._internal();

  late final BookRepository bookRepository;

  factory Appconfig() {
    return _instance;
  }

  Appconfig._internal() {
    bookRepository = BookFakeGateway();
  }
}