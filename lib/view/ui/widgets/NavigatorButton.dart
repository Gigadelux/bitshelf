import 'package:flutter/material.dart';

class NavigatorButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function()? onPressed;
  final bool selected;

  const NavigatorButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed, 
    required this.selected,
  });

  @override
  State<NavigatorButton> createState() => _NavigatorButtonState();
}

class _NavigatorButtonState extends State<NavigatorButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
            color: widget.selected? Colors.blue:Theme.of(context).secondaryHeaderColor,
            onPressed: widget.onPressed,
            child: ListTile(
              selected: widget.selected,
              selectedColor: Colors.blue,
              tileColor: Theme.of(context).secondaryHeaderColor,
              leading: Icon(widget.icon, color: Colors.white),
              title: Text(widget.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
            ),
          );
  }
}