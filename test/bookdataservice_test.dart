import 'package:flutter_test/flutter_test.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/gateway/BookFakeGateway.dart';
import 'package:bitshelf/core/AppConfig.dart';
import 'package:bitshelf/core/BookCRUDStrategy/BookFluxDataStrategy.dart';

void main() {
  late BookDatasetService service;
  late BookFakeGateway fakeGateway;
  late Book testBook1;
  late Book testBook2;
  late Book testBook3;

  setUp(() async {
    fakeGateway = BookFakeGateway({}, prepopulate: false);
    fakeGateway.reset();
    Appconfig().bookRepository = fakeGateway;
    Appconfig().bookDataStrategy = Bookfluxdatastrategy(fakeGateway);
    service = BookDatasetService();
    await service.importBooks();
    testBook1 = Book(
      codeISBN: 'TST1',
      title: 'Book One',
      author: 'Author A',
      genre: 'Fiction',
      review: 5,
      status: 'letto',
    );
    testBook2 = Book(
      codeISBN: 'TST2',
      title: 'Book Two',
      author: 'Author B',
      genre: 'Fantasy',
      review: 4,
      status: 'da leggere',
    );
    testBook3 = Book(
      codeISBN: 'TST3',
      title: 'Book Three',
      author: 'Author C',
      genre: 'Sci-Fi',
      review: 3,
      status: 'in lettura',
    );
  });

  test('Add book', () async {
    await service.addBook(testBook1);
    expect(service.books.any((b) => b.codeISBN == testBook1.codeISBN), isTrue);
  });

  test('Add duplicate book throws', () async {
    await service.addBook(testBook1);
    expect(() => service.addBook(testBook1), throwsArgumentError);
  });

  test('Remove book', () async {
    await service.addBook(testBook1);
    await service.removeBook(testBook1);
    expect(service.books.any((b) => b.codeISBN == testBook1.codeISBN), isFalse);
  });

  test('Remove non-existent book throws', () async {
    expect(() => service.removeBook(testBook1), throwsArgumentError);
  });

  test('Update book', () async {
    await service.addBook(testBook1);
    final updatedBook = Book(
      codeISBN: 'A1',
      title: 'Book One Updated',
      author: 'Author A',
      genre: 'Fiction',
      review: 4,
      status: 'letto',
    );
    await service.updateBook(testBook1, updatedBook);
    expect(service.books.any((b) => b.title == 'Book One Updated'), isTrue);
  });

  test('Import books populates list', () async {
    await service.addBook(testBook1);
    await service.addBook(testBook2);
    await service.importBooks();
    expect(service.books.length, greaterThanOrEqualTo(2));
  });

  test('Sort books ascending by title', () async {
    await service.addBook(testBook2);
    await service.addBook(testBook1);
    await service.addBook(testBook3);
    await service.sortBooks('title', true);
    final titles = service.books.map((b) => b.title).toList();
    expect(titles, orderedEquals(['Book One', 'Book Three', 'Book Two']));
  });

  test('Sort books descending by title', () async {
    await service.addBook(testBook2);
    await service.addBook(testBook1);
    await service.addBook(testBook3);
    await service.sortBooks('title', false);
    final titles = service.books.map((b) => b.title).toList();
    expect(titles, orderedEquals(['Book Two', 'Book Three', 'Book One']));
  });

  test('Sort books with field none reverses order', () async {
    await service.addBook(testBook1);
    await service.addBook(testBook2);
    await service.addBook(testBook3);
    await service.sortBooks('none', false);
    final codes = service.books.map((b) => b.codeISBN).toList();
    expect(codes, orderedEquals(['TST3', 'TST2', 'TST1']));
  });

  test('Apply changes clears pending', () async {
    await service.addBook(testBook1);
    await service.applyChanges();
    expect(service.pendingOperations.isEmpty, isTrue);
  });
}
