import 'dart:io';
import 'package:csv/csv.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';

class Csvbookgateway extends BookRepository { //TODO gateway testing
  @override
  Map<String, dynamic> config;
  Csvbookgateway(this.config) : super(config);
  void check() {
    if (!config.containsKey("csv_path") || !config.containsKey("csv_max_MB")) {
      throw Exception("BAD GATEWAY: Error configuration not valid for CSV gateway");
    }
  }

  Future<File> _getCsvFile() async {
    final path = config["csv_path"]!;
    return File(path);
  }

  List<String> _csvHeader() {
    return Book.empty().toMap().keys.toList();
  }

  List<dynamic> _bookToCsvRow(Book book) => book.toMap().values.toList();

  Book _bookFromCsvRow(List<dynamic> row) {
    return Book.fromList(row);
  }

  Future<List<Book>> _readBooks() async {
    final file = await _getCsvFile();
    if (!await file.exists()) return [];
    final content = await file.readAsString();
    final rows = CsvToListConverter().convert(content, eol: '\n');
    if (rows.isEmpty) return [];
    return rows.skip(1).map(_bookFromCsvRow).toList();
  }

  Future<void> _writeBooks(List<Book> books) async {
    final file = await _getCsvFile();
    final rows = [_csvHeader(), ...books.map(_bookToCsvRow)];
    final csv = const ListToCsvConverter().convert(rows);
    await file.writeAsString(csv);
    await _checkFileSize();
  }

  Future<void> _checkFileSize() async {
    final file = await _getCsvFile();
    final maxMB = double.tryParse(config["csv_max_MB"] ?? "1") ?? 1;
    final maxBytes = (maxMB * 1024 * 1024).toInt();
    if (await file.exists() && await file.length() > maxBytes) {
      throw Exception("CSV file exceeds max size of ${config["csv_max_MB"]!} MB");
    }
  }

  @override
  Future<void> add(Book book) async {
    check();
    final books = await _readBooks();
    if (books.any((b) => b.id == book.id)) {
      throw Exception("Book with id \\${book.id} already exists");
    }
    books.add(book);
    await _writeBooks(books);
  }

  @override
  Future<void> delete(String id) async {
    check();
    final books = await _readBooks();
    books.removeWhere((b) => b.id == id);
    await _writeBooks(books);
  }

  @override
  Future<void> export(List<Book> toExport) async {
    check();
    final file = await _getCsvFile();
    final rows = [_csvHeader(), ...toExport.map(_bookToCsvRow)];
    final csv = const ListToCsvConverter().convert(rows);
    await file.writeAsString(csv);
    await _checkFileSize();
  }

  @override
  Future<List<Book>> getAll() async {
    check();
    return await _readBooks();
  }

  @override
  Future<Book?> getById(String id) async {
    check();
    final books = await _readBooks();
    try {
      return books.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> update(Book book) async {
    check();
    final books = await _readBooks();
    final idx = books.indexWhere((b) => b.id == book.id);
    if (idx == -1) throw Exception("Book with id \\${book.id} not found");
    books[idx] = book;
    await _writeBooks(books);
  }
}