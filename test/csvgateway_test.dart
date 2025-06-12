import 'dart:io';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/gateway/CsvBookGateway.dart';

void main() {
  group('Csvbookgateway Tests', () {
    late Csvbookgateway gateway;
    late String testCsvPath;
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('csv_gateway_test_');
      testCsvPath = path.join(tempDir.path, 'test_books.csv');
      gateway = Csvbookgateway({
        'csv_path': testCsvPath,
        'csv_max_MB': '1'
      });
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    group('Integration Tests', () {
      test('should perform complete CRUD operations', () async {
        // Create
        final originalBook = Book(
          title: 'CRUD Test Book',
          author: 'CRUD Author',
          codeISBN: '999-999-999',
          genre: 'Test Genre',
          review: 3,
          status: 'to read'
        );

        await gateway.add(originalBook);

        // Read
        var foundBook = await gateway.getByTitleAndAuthor('CRUD Test Book', 'CRUD Author');
        expect(foundBook, isNotNull);
        expect(foundBook!.review, equals(3));

        // Update
        final updatedBook = foundBook.copyWith(
          review: 5,
          status: 'completed'
        );
        await gateway.update(updatedBook);

        foundBook = await gateway.getByTitleAndAuthor('CRUD Test Book', 'CRUD Author');
        expect(foundBook!.review, equals(5));
        expect(foundBook.status, equals('completed'));

        // Delete
        await gateway.delete(foundBook);

        foundBook = await gateway.getByTitleAndAuthor('CRUD Test Book', 'CRUD Author');
        expect(foundBook, isNull);

        final allBooks = await gateway.getAll();
        expect(allBooks, isEmpty);
      });
    });
       group('File Size Validation Tests', () {
      test('should throw exception when file exceeds max size', () async {
        final smallSizeGateway = Csvbookgateway({
          'csv_path': testCsvPath,
          'csv_max_MB': '0.001' //very small limit...
        });

        final testBook = Book(
          title: 'A' * 1000, //...to exceed size limit
          author: 'B' * 1000,
          codeISBN: 'C' * 1000,
          genre: 'D' * 1000,
          review: 5,
          status: 'E' * 1000
        );

        expect(
          () => smallSizeGateway.add(testBook),
          throwsA(isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('exceeds max size')
          ))
        );
      });

    });

  });

}