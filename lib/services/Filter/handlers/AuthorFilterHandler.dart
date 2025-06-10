import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/Filter/handlers/FilterHandler.dart';

class AuthorFilterHandler extends FilterHandler{
  AuthorFilterHandler({super.next, required super.paramether});

  @override
  List<Book> filter(List<Book> books) {
    List<Book> res = books.where((book)=> book.author==paramether).toList();
    if(next == null){
      return res;
    }else{
      return next!.filter(res);
    }
  }

}