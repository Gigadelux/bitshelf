import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/Filter/handlers/FilterHandler.dart';

class GenreFilterHandler extends FilterHandler{
  GenreFilterHandler({super.next, required super.paramether});

  @override
  List<Book> filter(List<Book> books) {
    List<Book> res = books.where((book)=> book.genre==paramether).toList();
    if(next == null){
      return res;
    }else{
      return next!.filter(res);
    }
  }

}