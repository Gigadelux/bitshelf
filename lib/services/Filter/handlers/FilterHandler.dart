import 'package:bitshelf/data/models/Book.dart';

abstract class FilterHandler {
  FilterHandler? next;
  final String paramether;
  FilterHandler({this.next, required this.paramether});

  List<Book> filter(List<Book> books);
}