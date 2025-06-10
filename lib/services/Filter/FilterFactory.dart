import 'package:bitshelf/services/Filter/handlers/AuthorFilterHandler.dart';
import 'package:bitshelf/services/Filter/handlers/GenreFilterHandler.dart';
import 'package:bitshelf/services/Filter/handlers/ReviewDownFilterHandler.dart';
import 'package:bitshelf/services/Filter/handlers/StatusFilterHandler.dart';

class FilterFactory {
  static final Map<String, Function(List<String>)> filters = { //title by default filterChain head
    "author": (values) => values.isEmpty || values.first.isEmpty? null: AuthorFilterHandler(paramether: values.first),
    "review": (values) => values.isEmpty || (values.first.isEmpty && values[1].isEmpty)? null:ReviewFilterHandler(lowerBound: values[0], upperBound: values[1]),
    "genre":  (values) => values.isEmpty || values.first.isEmpty? null: GenreFilterHandler(paramether: values.first),
    "status":  (values) => values.isEmpty || values.first.isEmpty? null: StatusFilterHandler(paramether: values.first),
  };

  static void registerFilter(String name, Function(List<String>) filter) { //An example for more scalability
    filters[name] = filter;
  }

}