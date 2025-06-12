// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  late String _title;
  late String _author;
  late String _codeISBN;
  late String _genre;
  late int _review; // da 1 a 5 stelle
  late String _status; // es. "letto", "da leggere", "in lettura"

  // Primary keys
  String get title => _title;
  set title(String value) => _title = value;

  String get author => _author;
  set author(String value) => _author = value;

  String get codeISBN => _codeISBN;
  set codeISBN(String value) => _codeISBN = value;

  String get genre => _genre;
  set genre(String value) => _genre = value;

  int get review => _review;
  set review(int value) => _review = value;

  String get status => _status;
  set status(String value) => _status = value;
  
  void setReview(int value) {
    if (value < 1 || value > 5) {
      throw ArgumentError('Review must be between 1 and 5');
    }
    _review = value;
  }
  
  Book._({
    required String title,
    required String author,
    required int review,
    required String codeISBN,
    required String genre,
    required String status,
  })  : _title = title,
        _author = author,
        _review = review,
        _codeISBN = codeISBN,
        _genre = genre,
        _status = status;
  
  // Public factory constructor with review validation (between 1 and 5)
  factory Book({
    required String title,
    required String author,
    required int review,
    required String codeISBN,
    required String genre,
    required String status,
  }) {
    if (review < 1 || review > 5) {
      throw RangeError.range(review, 1, 5, 'review', 'Review must be between 1 and 5');
    }
    return Book._(
      title: title,
      author: author,
      review: review,
      codeISBN: codeISBN,
      genre: genre,
      status: status,
    );
  }
  factory Book.empty() {
    return Book(
      title: '',
      author: '',
      codeISBN: '',
      genre: '',
      review: 1,
      status: '',
    );
  }
  factory Book.fromList(List<dynamic> list) {
    if (list.length != 6) {
      throw ArgumentError('List must have exactly 6 elements');
    }
    return Book(
      title: "${list[0]}",
      author: list[1] as String,
      codeISBN: "${list[2]}",
      genre: list[3] as String,
      review: list[4],
      status: list[5] as String,
    );
  }

  Book copyWith({
    String? title,
    String? author,
    String? codeISBN,
    String? genre,
    int? review,
    String? status,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      codeISBN: codeISBN ?? this.codeISBN,
      genre: genre ?? this.genre,
      review: review ?? this.review,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'author': author,
      'codeISBN': codeISBN,
      'genre': genre,
      'review': review,
      'status': status,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: "${map['title']}",
      author: map['author'] as String,
      codeISBN: "${map['codeISBN']}",
      genre: map['genre'] as String,
      review: map['review'] as int,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source) as Map<String, dynamic>);

  static void check(Book book) {
    if (book.title.isEmpty) {
      throw ArgumentError('Book title cannot be empty');
    }
    if (book.author.isEmpty) {
      throw ArgumentError('Book author cannot be empty');
    }
    if (book.codeISBN.isEmpty) {
      throw ArgumentError('Book codeISBN cannot be empty');
    }
    if (book.genre.isEmpty) {
      throw ArgumentError('Book genre cannot be empty');
    }
    if (book.review < 1 || book.review > 5) {
      throw ArgumentError('Book review must be between 1 and 5');
    }
    if (book.status.isEmpty) {
      throw ArgumentError('Book status cannot be empty');
    }
  }

  @override
  String toString() {
    return 'Book(title: $title, author: $author, codeISBN: $codeISBN, genre: $genre, review: $review, status: $status)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.author == author &&
      other.codeISBN == codeISBN &&
      other.genre == genre &&
      other.review == review &&
      other.status == status;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      author.hashCode ^
      codeISBN.hashCode ^
      genre.hashCode ^
      review.hashCode ^
      status.hashCode;
  }
}
