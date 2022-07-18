import 'package:flutter/material.dart';
import 'resources/LoginPage.dart';
import 'resources/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes:<String,Widget Function(BuildContext)> {
        '/': (context) =>  LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}