import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/Filter/handlers/FilterHandler.dart';

class ReviewFilterHandler extends FilterHandler{
  final String lowerBound;
  final String upperBound;
  @override
  ReviewFilterHandler({super.next, required this.lowerBound, required this.upperBound})
      : super(paramether: upperBound);

  @override
  List<Book> filter(List<Book> books) {
    int? lowerBound = int.tryParse(paramether);
    if(lowerBound==null) return books;
    List<Book> res = [...books];
    int? upperBoundValue = int.tryParse(upperBound);
    if (lowerBound > 5 || lowerBound < 1 || upperBoundValue == null || upperBoundValue > 5 || upperBoundValue < 1 || lowerBound > upperBoundValue) {
      print("Error: review lowerBound or upperBound is not valid");
    } else {
      res = books.where((book) => book.review >= lowerBound && book.review <= upperBoundValue).toList();
    }
    if(next == null){
      return res;
    }else{
      return next!.filter(res);
    }
  }

}