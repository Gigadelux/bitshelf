import 'package:bitshelf/core/BookCRUDStrategy/BookDataStrategy.dart';
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
  Future<void> delete(String id) async{
    Book? book = await _bookRepository.getById(id);
    if(book==null) throw Exception("Error in cached memory: book of id $id does not exist in selected gateway");
    _pending[book] = CrudOperation.delete;
  }

  @override
  Future<void> update(Book book) async{
    try{
      _pending[book] = CrudOperation.delete;
    }catch(e){
      print("Error in cached memory: book of id${book.id} does not exist");
      return Future.value();
    }
  }

  @override
  Future<void> commit() async{
    for(Book book in _pending.keys.toList()){
      switch (_pending[book]) {
        case CrudOperation.add:
          await _bookRepository.add(book);
          break;
        case CrudOperation.delete:
          await _bookRepository.delete(book.id);
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

enum CrudOperation {
  add,
  delete,
  update
}