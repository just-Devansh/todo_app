import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/Pages/home_page.dart';

void main() async {
  // init the Hive
  await Hive.initFlutter();

  // open a box
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // T O  E X P L O R E
      // theme: ThemeData(),
    );
  }
}
