import 'package:flutter/material.dart';
import 'package:bitshelf/view/ui/pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        secondaryHeaderColor: Color.fromARGB(255, 46, 52, 49),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue
        ),
        buttonTheme: ButtonThemeData(buttonColor: const Color.fromARGB(255, 0, 94, 255),)
      ),
      home: const HomePage(),
    );
  }
}
