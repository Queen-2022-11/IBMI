import 'package:flutter/material.dart';

import 'package:ibmi/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IBMI",
      theme: ThemeData(
        primaryColor: Colors.lightBlue, // Set the app bar color
      ),
      home: MainPage(),
    );
  }
}