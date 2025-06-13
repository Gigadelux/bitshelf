import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/services/Filter/FilterChainService.dart';
import 'package:bitshelf/services/Filter/FilterChainState.dart';
import 'package:flutter/material.dart';
import 'package:bitshelf/view/ui/pages/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ //DO NOT CHANGE ORDER FOR *ANY REASON IN THE WORLD* (hint: constructors problem🙂)
        ChangeNotifierProvider(create: (_) => BookDatasetService()),
        ChangeNotifierProvider(create: (_)=>FilterChainState()),
        ChangeNotifierProvider(create: (context)=> FilterChainService(context)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitshelf',
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          primaryContainer: Colors.white,
        ),
        dataTableTheme: DataTableThemeData(
          dataRowColor: WidgetStateProperty.all(Colors.white),
          headingRowColor: WidgetStateProperty.all(Colors.white),
          decoration: BoxDecoration(
            color: Colors.white,
          )
        ),
        cardColor: Colors.white,
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
