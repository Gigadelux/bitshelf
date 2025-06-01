import 'package:flutter/material.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
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
                  Text("Settings", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}