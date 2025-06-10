//CoR pattern

import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/services/Filter/FilterChainState.dart';
import 'package:bitshelf/services/Filter/FilterFactory.dart';
import 'package:bitshelf/services/Filter/handlers/AuthorFilterHandler.dart';
import 'package:bitshelf/services/Filter/handlers/FilterHandler.dart';
import 'package:bitshelf/services/Filter/handlers/TitleSearchFilterHandler.dart';
import 'package:bitshelf/view/ui/widgets/drawers/drawerValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChainService extends ChangeNotifier {
  late FilterHandler head;
  FilterHandler? last;
  List<Book> filteredBooks = [];
  late FilterChainState state;
  late BuildContext context;

  FilterChainService(BuildContext context) {
    head = TitleSearchFilterHandler(paramether: '');
    this.context = context;
    final bookDataService = Provider.of<BookDatasetService>(context, listen: false);
    state = Provider.of<FilterChainState>(context,listen: false);
    filteredBooks = List.from(bookDataService.books);
    bookDataService.addListener(() { //subscribe
      filteredBooks = List.from(bookDataService.books);
      notifyListeners();
    });
    state.addListener(_rebuildChain);
  }

  void applyFilters() {
    filteredBooks = head.filter(filteredBooks);
    notifyListeners();
  }

  
  void updateTitleSearch(String title) {
      if (head is TitleSearchFilterHandler) {
        (head as TitleSearchFilterHandler).paramether = title;
        applyFilters();
      }
  }

  void addFilterHandler(FilterHandler handler) {
    if (handler is TitleSearchFilterHandler) {
      throw Exception('Cannot add another TitleSearchFilterHandler to the chain.');
    }
    if (last == null) {
      head.next = handler;
    } else {
      last!.next = handler;
    }
    last = handler;
  }

  void _rebuildChain() {
    head.next = null;
    last = null;
    state.filterParams.forEach(
      (filter,params){
        if(params!= null){
          addFilterHandler(FilterFactory.filters[filter]!(params));
        }
      }
    );
  }
  void resetBooks(){
    filteredBooks = Provider.of<BookDatasetService>(context, listen: false).books;
    notifyListeners();
  }
  
}
