import 'package:bitshelf/core/BookCRUDStrategy/BookDataStrategy.dart';
import 'package:bitshelf/core/BookCRUDStrategy/BookFluxDataStrategy.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';
import 'package:bitshelf/data/gateway/BookFakeGateway.dart';

class Appconfig { //State pattern
  static final Appconfig _instance = Appconfig._internal();

  late BookRepository bookRepository;
  late Bookdatastrategy bookDataStrategy;

  factory Appconfig() {
    return _instance;
  }

  Appconfig._internal() { //default
    bookRepository = BookFakeGateway();
    bookDataStrategy = Bookfluxdatastrategy(bookRepository);
  }
  void updateRepository(BookRepository newbookRepository){
    bookRepository = newbookRepository;
    bookDataStrategy.repository = newbookRepository;
  }
  void updateStrategy(Bookdatastrategy newBookDataStrategy){
    bookDataStrategy = newBookDataStrategy;
  }
}