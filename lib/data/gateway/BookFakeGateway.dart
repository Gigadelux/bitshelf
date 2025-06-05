import 'package:bitshelf/data/repository/BookRepository.dart';
import 'package:bitshelf/data/models/Book.dart';

class BookFakeGateway extends BookRepository{
  BookFakeGateway(super.config);

  @override
  Future<List<Book>> getAll() {
    return Future.value([
      Book(
        id: '1',
        title: '1984',
        author: 'George Orwell',
        codeISBN: '9780451524935',
        genre: 'Dystopian',
        review: 5,
        status: 'letto',
      ),
      Book(
        id: '2',
        title: 'Brave New World',
        author: 'Aldous Huxley',
        codeISBN: '9780060850524',
        genre: 'Science Fiction',
        review: 4,
        status: 'da leggere',
      ),
      Book(
        id: '3',
        title: 'Fahrenheit 451',
        author: 'Ray Bradbury',
        codeISBN: '9781451673319',
        genre: 'Dystopian',
        review: 5,
        status: 'in lettura',
      ),
      Book(
        id: '4',
        title: 'The Hobbit',
        author: 'J.R.R. Tolkien',
        codeISBN: '9780547928227',
        genre: 'Fantasy',
        review: 5,
        status: 'letto',
      ),
      Book(
        id: '5',
        title: 'To Kill a Mockingbird',
        author: 'Harper Lee',
        codeISBN: '9780061120084',
        genre: 'Classic',
        review: 4,
        status: 'da leggere',
      ),
    ]);
  }
  
  @override
  Future<void> add(Book book) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> delete(String id) {
    throw UnimplementedError();
  }
  
  @override
  Future<Book?> getById(String id) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> update(Book book) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> export(List<Book> toExport) {
    throw UnimplementedError();
  }
  
}