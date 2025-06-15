import 'package:bitshelf/core/BookCRUDStrategy/BookDataStrategy.dart';
import 'package:bitshelf/core/CrudOperation.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/data/repository/BookRepository.dart';

class Bookdeferreddatastrategy extends Bookdatastrategy{
  BookRepository _bookRepository;
  Bookdeferreddatastrategy(this._bookRepository);
  
  final Map<Book,CrudOperation> _pending = {};

  @override
  BookRepository get repository => _bookRepository;
  Map<Book,CrudOperation> get pending_edits => Map.unmodifiable(_pending);

  @override
  set repository(BookRepository repo) => _bookRepository = repo;

  @override
  Future<void> add(Book book) async{
    _pending[book] = CrudOperation.add;
  }

  @override
  Future<void> delete(Book toDelete) async{
    Book? book = await _bookRepository.getByTitleAndAuthor(toDelete.title, toDelete.author);
    if(book==null) throw Exception("Error in cached memory: book of title ${toDelete.title} does not exist in selected gateway");
    _pending[book] = CrudOperation.delete;
  }

  @override
  Future<void> update(Book book) async{
    try{
      _pending[book] = CrudOperation.update;
    }catch(e){
      print("Error in cached memory: book of title ${book.title} and author ${book.author} does not exist");
      return Future.value();
    }
  }
  void clear(){
    _pending.clear();
  }

  @override
  Future<void> commit() async{
    for(Book book in _pending.keys.toList()){
      switch (_pending[book]) {
        case CrudOperation.add:
          await _bookRepository.add(book);
          break;
        case CrudOperation.delete:
          await _bookRepository.delete(book);
          break;
        case CrudOperation.update:
          await _bookRepository.update(book);
          break;
        default:
          break;
      }
    }
    _pending.clear();
  }

}