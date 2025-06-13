import 'package:flutter_test/flutter_test.dart';
import 'package:bitshelf/services/Filter/FilterChainService.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/services/Filter/FilterChainState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitshelf/services/Filter/handlers/FilterHandler.dart';
import 'package:bitshelf/core/CrudOperation.dart';

// Dummy BookDatasetService for testing
class DummyBookDatasetService extends ChangeNotifier implements BookDatasetService {
  @override
  List<Book> books;
  DummyBookDatasetService(this.books);
  // No-op implementations for abstract methods
  @override
  Future<void> addBook(Book book) async {}
  @override
  Future<void> removeBook(Book book) async {}
  @override
  Future<void> importBooks() async {}
  @override
  Future<void> updateBook(Book oldBook, Book newBook) async {}
  @override
  Future<void> applyChanges() async {}
  @override
  Future<void> sortBooks(String field, bool ascending) async {}
  @override
  Map<Book, CrudOperation> get pendingOperations => {};
}

// Dummy FilterChainState for testing
class DummyFilterChainState extends ChangeNotifier implements FilterChainState {
  @override
  Map<String, List<String>?> filterParams = {};
  @override
  void updateFilter(String filterKey, List<String>? value) {}
  @override
  void clearFilter(String filterKey) {}
  @override
  void clearAllFilters() {}
}

void main() {
  late List<Book> books;
  late DummyBookDatasetService bookService;
  late DummyFilterChainState filterState;
  late Widget testWidget;

  setUp(() {
    books = [
      Book(title: 'Dune', author: 'Frank Herbert', codeISBN: '1', genre: 'Sci-Fi', review: 5, status: 'letto'),
      Book(title: 'Foundation', author: 'Isaac Asimov', codeISBN: '2', genre: 'Sci-Fi', review: 4, status: 'letto'),
      Book(title: 'The Hobbit', author: 'J.R.R. Tolkien', codeISBN: '3', genre: 'Fantasy', review: 5, status: 'da leggere'),
    ];
    bookService = DummyBookDatasetService(books);
    filterState = DummyFilterChainState();
    testWidget = MultiProvider(
      providers: [
        ChangeNotifierProvider<BookDatasetService>.value(value: bookService),
        ChangeNotifierProvider<FilterChainState>.value(value: filterState),
      ],
      child: Builder(
        builder: (context) => Container(),
      ),
    );
  });

  testWidgets('Title search filter works', (tester) async {
    await tester.pumpWidget(testWidget);
    final context = tester.element(find.byType(Container));
    final filterService = FilterChainService(context);
    filterService.updateTitleSearch('Dune');
    expect(filterService.filteredBooks.length, 1);
    expect(filterService.filteredBooks.first.title, 'Dune');
    filterService.updateTitleSearch('');
    expect(filterService.filteredBooks.length, 3);
  });

  testWidgets('Adding a second filter handler works', (tester) async {
    await tester.pumpWidget(testWidget);
    final context = tester.element(find.byType(Container));
    final filterService = FilterChainService(context);
    // Add a filter that only allows books with review >= 5
    filterService.addFilterHandler(_ReviewFilterHandler(minReview: 5));
    filterService.applyFilters();
    expect(filterService.filteredBooks.length, 2);
    expect(filterService.filteredBooks.every((b) => b.review == 5), isTrue);
  });
}

// Dummy filter handler for review >= minReview
class _ReviewFilterHandler extends FilterHandler {
  final int minReview;
  _ReviewFilterHandler({required this.minReview}) : super(paramether: '');
  @override
  List<Book> filter(List<Book> books) {
    final filtered = books.where((b) => b.review >= minReview).toList();
    return next?.filter(filtered) ?? filtered;
  }
}
