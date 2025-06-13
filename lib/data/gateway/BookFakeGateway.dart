import 'package:bitshelf/data/repository/BookRepository.dart';
import 'package:bitshelf/data/models/Book.dart';

class BookFakeGateway extends BookRepository{
  final List<Book> _initialBooks = [
    Book(
      title: '1984',
      author: 'George Orwell',
      codeISBN: '9780451524935',
      genre: 'Dystopian',
      review: 5,
      status: 'letto',
    ),
    Book(
      title: 'Brave New World',
      author: 'Aldous Huxley',
      codeISBN: '9780060850524',
      genre: 'Science Fiction',
      review: 4,
      status: 'da leggere',
    ),
    Book(
      title: 'Fahrenheit 451',
      author: 'Ray Bradbury',
      codeISBN: '9781451673319',
      genre: 'Dystopian',
      review: 5,
      status: 'in lettura',
    ),
    Book(
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      codeISBN: '9780547928227',
      genre: 'Fantasy',
      review: 5,
      status: 'letto',
    ),
    Book(
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      codeISBN: '9780061120084',
      genre: 'Classic',
      review: 4,
      status: 'da leggere',
    ),
  ];
  final List<Book> _books = [];

  void reset() {
    _books.clear();
    if (_prepopulate) {
      _books.addAll(_initialBooks.map((b) => Book(
        title: b.title,
        author: b.author,
        codeISBN: b.codeISBN,
        genre: b.genre,
        review: b.review,
        status: b.status,
      )));
    }
  }

  final bool _prepopulate;
  BookFakeGateway(super.config, {bool prepopulate = true}) : _prepopulate = prepopulate {
    if (_prepopulate) {
      reset();
    } else {
      _books.clear();
    }
  }

  @override
  Future<List<Book>> getAll() async {
    return List<Book>.from(_books);
  }

  @override
  Future<void> add(Book book) async {
    if (_books.any((b) => b.codeISBN == book.codeISBN)) {
      throw ArgumentError('Book already exists');
    }
    _books.add(book);
  }

  @override
  Future<void> delete(Book book) async {
    final before = _books.length;
    _books.removeWhere((b) => b.codeISBN == book.codeISBN);
    if (_books.length == before) {
      throw ArgumentError('Book not found');
    }
  }

  @override
  Future<void> update(Book book) async {
    final idx = _books.indexWhere((b) => b.codeISBN == book.codeISBN);
    if (idx == -1) {
      throw ArgumentError('Book not found');
    }
    _books[idx] = book;
  }

  @override
  Future<Book?> getByTitleAndAuthor(String title, String author) async {
    try {
      return _books.firstWhere((b) => b.title == title && b.author == author);
    } catch (_) {
      return null;
    }
  }
}