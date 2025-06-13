import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/gateway/CSVBookGateway.dart';
import 'package:bitshelf/services/encryption/EncryptionService.dart';

class EncryptedBookGateway extends Csvbookgateway { //Simil Decorator
  late final EncryptionService encryptionService;

  EncryptedBookGateway(super.config);


  Book _encryptBook(Book book) {
    return Book(
      title: encryptionService.encrypt(book.title),
      author: encryptionService.encrypt(book.author),
      codeISBN: encryptionService.encrypt(book.codeISBN),
      genre: encryptionService.encrypt(book.genre),
      review: book.review, // review not encrypted
      status: encryptionService.encrypt(book.status),
    );
  }
  
  Book _decryptBook(Book book) {
    return Book(
      title: encryptionService.decrypt(book.title),
      author: encryptionService.decrypt(book.author),
      codeISBN: encryptionService.decrypt(book.codeISBN),
      genre: encryptionService.decrypt(book.genre),
      review: book.review,
      status: encryptionService.decrypt(book.status),
    );
  }


  Future<List<Book>> importBooks() async {
    final encryptedBooks = await super.getAll();
    return encryptedBooks.map(_decryptBook).toList();
  }

  @override
  Future<void> add(Book book) async {
    await super.add(_encryptBook(book));
  }

  @override
  Future<void> update(Book book) async {
    await super.update(_encryptBook(book));
  }

  @override
  Future<void> delete(Book book) async {
    await super.delete(_encryptBook(book));
  }

  @override
  Future<Book?> getByTitleAndAuthor(String title, String author) async {
    final encryptedTitle = encryptionService.encrypt(title);
    final encryptedAuthor = encryptionService.encrypt(author);
    final encryptedBook = await super.getByTitleAndAuthor(encryptedTitle, encryptedAuthor);
    return encryptedBook != null ? _decryptBook(encryptedBook) : null;
  }

  @override
  Future<List<Book>> getAll() async {
    final encryptedBooks = await super.getAll();
    return encryptedBooks.map(_decryptBook).toList();
  }
}
