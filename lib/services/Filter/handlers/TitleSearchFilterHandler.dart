import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/Filter/handlers/FilterHandler.dart';

class TitleSearchFilterHandler extends FilterHandler{
  TitleSearchFilterHandler({super.next, required super.paramether});

  @override
  List<Book> filter(List<Book> books) {
    List<Book> res = books.where((book)=> book.title.contains(paramether)).toList();
    if(next == null){
      return res;
    }else{
      return next!.filter(res);
    }
  }
  
  set paramether(String value) => paramether = value;

}