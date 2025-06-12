import 'package:bitshelf/controllers/BookController.dart';
import 'package:bitshelf/core/CrudOperation.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/view/ui/widgets/CrudOpWidget.dart';
import 'package:bitshelf/view/ui/widgets/desktopToast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryStagedDrawer extends StatelessWidget {
  const HistoryStagedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    BookDatasetService bookDatasetService = Provider.of<BookDatasetService>(context);
    Map<Book, CrudOperation> pending = bookDatasetService.pendingOperations;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'Changes to commit:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              ),
              SizedBox(height: 5),
              Text(
              '(Only using deferred strategy)',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              ),
              SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  onPressed: () async{
                    try{
                      Bookcontroller().commitChanges();
                      Desktoptoast().showDesktopToast(context, "Changes committed successfully!");
                    }catch(e){
                      Desktoptoast().showDesktopToast(context, "Error $e");
                    }
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Commit'),
                  ),
                ),
              ),
              ],
            ),
          ),
        pending.keys.isEmpty?
          Center(
            child: Text("Nothing staged👀"),
          ):
          SizedBox(),
        ...List.generate(pending.keys.length, (index)=>
          Column(
            children: [
              Text(pending.keys.toList()[index].title),
              CrudOpWidget(crudOperation: pending[pending.keys.toList()[index]]!)
            ],
          )
        ),
      ],
    );
  }
}