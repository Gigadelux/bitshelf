import 'dart:io';
import 'package:csv/csv.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';

class Csvbookgateway extends BookRepository { //TODO gateway testing
  @override
  Map<String, dynamic> config;
  
  Csvbookgateway(this.config) : super(config) {
    check();
  }
  void check() {
    if (!config.containsKey("csv_path") || !config.containsKey("csv_max_MB")) {
      throw Exception("BAD GATEWAY: Error configuration not valid for CSV gateway");
    }
    final csvPath = config["csv_path"];
    final file = File(csvPath);
    if (!file.existsSync()) {
      throw Exception("BAD GATEWAY: CSV file does not exist at path '$csvPath'");
    }
    if (!csvPath.toLowerCase().endsWith('.csv')) {
      throw Exception("BAD GATEWAY: File at '$csvPath' is not a CSV file");
    }
    final maxMB = double.tryParse(config["csv_max_MB"].toString()) ?? 1;
    final maxBytes = (maxMB * 1024 * 1024).toInt();
    if (file.lengthSync() > maxBytes) {
      throw Exception("BAD GATEWAY: CSV file exceeds max size of ${config["csv_max_MB"]} MB");
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
    if (books.any((b) => b.title == book.title && b.author == book.author)) {
      throw Exception("Book with title '${book.title}' and author '${book.author}' already exists");
    }
    books.add(book);
    await _writeBooks(books);
  }

  @override
  Future<void> delete(Book book) async {
    check();
    final books = await _readBooks();
    books.removeWhere((b) => b.title == book.title && b.author == book.author);
    await _writeBooks(books);
  }

  // @override
  // Future<void> export(List<Book> toExport) async {
  //   check();
  //   final file = await _getCsvFile();
  //   final rows = [_csvHeader(), ...toExport.map(_bookToCsvRow)];
  //   final csv = const ListToCsvConverter().convert(rows);
  //   await file.writeAsString(csv);
  //   await _checkFileSize();
  // }

  @override
  Future<List<Book>> getAll() async {
    check();
    return await _readBooks();
  }

  @override
  Future<Book?> getByTitleAndAuthor(String title, String author) async {
    check();
    final books = await _readBooks();
    try {
      return books.firstWhere((b) => b.title == title && b.author == author);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> update(Book book) async {
    check();
    final books = await _readBooks();
    final idx = books.indexWhere((b) => b.title == book.title && b.author == book.author);
    if (idx == -1) throw Exception("Book with title '${book.title}' and author '${book.author}' not found");
    books[idx] = book;
    await _writeBooks(books);
  }
  
}