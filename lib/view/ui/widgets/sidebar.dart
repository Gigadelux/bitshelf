import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final List<Widget> navigationButtons;
  const Sidebar({super.key, required this.navigationButtons});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      width: MediaQuery.of(context).size.width/4,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("lib/view/ui/assets/logo.png", width: MediaQuery.of(context).size.width/8,),
              Text("Bitshelf", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)
            ],
          ),
          SizedBox(height: 100,),
          ...widget.navigationButtons
        ],
      ),
    );
  }
}