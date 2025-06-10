import 'package:flutter/material.dart';
import 'package:bitshelf/view/ui/widgets/drawers/drawerValues.dart' as drawerV;

class DrawerTree extends StatelessWidget {
  final String operation;
  const DrawerTree({super.key, required this.operation});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: drawerV.values[operation] ?? const SizedBox.shrink(),
    );
  }
}