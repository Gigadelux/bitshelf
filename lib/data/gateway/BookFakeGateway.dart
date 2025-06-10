import 'package:bitshelf/data/repository/BookRepository.dart';
import 'package:bitshelf/data/models/Book.dart';

class BookFakeGateway extends BookRepository{
  BookFakeGateway(super.config);

  @override
  Future<List<Book>> getAll() {
    return Future.value([
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
    ]);
  }
  
  @override
  Future<void> add(Book book) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> delete(Book book) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> update(Book book) {
    throw UnimplementedError();
  }
  
  @override
  Future<Book?> getByTitleAndAuthor(String title, String author) {
    // TODO: implement getByTitleAndAuthor
    throw UnimplementedError();
  }
  
}