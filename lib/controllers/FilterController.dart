import 'package:bitshelf/services/Filter/FilterChainService.dart';
import 'package:bitshelf/services/Filter/FilterChainState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterController {
  final BuildContext context;
  FilterController(this.context);
  void search(String title){
    Provider.of<FilterChainService>(context, listen: false).updateTitleSearch(title);
  }
  void addFilter(String filterKey, List<String> value){
    Provider.of<FilterChainState>(context, listen: false).updateFilter(filterKey, value);
  }
  void applyFilters(){
    Provider.of<FilterChainService>(context, listen: false).applyFilters();
  }
  void resetFilters(){
    Provider.of<FilterChainState>(context, listen: false).clearAllFilters();
    Provider.of<FilterChainService>(context, listen: false).resetBooks();
  }
}