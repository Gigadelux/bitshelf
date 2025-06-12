import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:csv/csv.dart';
import 'dart:io';

class ExporterService {
  final BookDatasetService _bookDatasetService = BookDatasetService(); 
  
  Future<void> export(String path) async {
    final books = _bookDatasetService.books;
    final rows = [_csvHeader(), ...books.map(_bookToCsvRow)];
    final csv = const ListToCsvConverter().convert(rows);
    final file = await _getCsvFile(path);
    await file.writeAsString(csv);
  }

  List<String> _csvHeader() {
    return Book.empty().toMap().keys.toList();
  }
  
  List<String> _bookToCsvRow(Book book) {
    return book.toMap().values.map((e) => e.toString()).toList();
  }

  Future<dynamic> _getCsvFile(String path) async {
    final file = File(path);
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    return file;
  }
}