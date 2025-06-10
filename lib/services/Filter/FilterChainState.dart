import 'package:bitshelf/services/Filter/FilterFactory.dart';
import 'package:flutter/material.dart';

class FilterChainState extends ChangeNotifier {
  Map<String, List<String>?> filterParams = {};

  void updateFilter(String filterKey, List<String>? value) {
    if (!(FilterFactory.filters.keys.contains(filterKey))) throw ArgumentError("Invalid filter");
    if(value==null || value.isEmpty) throw ArgumentError("Invalid values");
    filterParams[filterKey] = value;
    notifyListeners();
  }

  void clearFilter(String filterKey) {
    filterParams[filterKey] = null;
    notifyListeners();
  }

  void clearAllFilters() {
    filterParams.clear();
    notifyListeners();
  }
}