import 'package:bitshelf/core/CrudOperation.dart';
import 'package:flutter/material.dart';

class CrudOpWidget extends StatelessWidget {
  final CrudOperation crudOperation;
  CrudOpWidget({super.key, required this.crudOperation}); //widget tree rebuilding
  //0 Add, 1 Delete, 2 Update
  final List<Color> opColor = [Colors.green, Colors.red, Colors.yellow];
  final List<String> icons = ["➕", "⚠️", "✒️"];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: opColor[crudOperation.index],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text("${crudOperation.toString()}  ${icons[crudOperation.index]}"),
        ),
      ),
    );
  }
}