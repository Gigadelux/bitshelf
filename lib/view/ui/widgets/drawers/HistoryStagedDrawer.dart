import 'package:bitshelf/core/CrudOperation.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/view/ui/widgets/CrudOpWidget.dart';
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
          child: Text(
            'Changes to commit:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
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