import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Profile", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}