import 'package:flutter/material.dart';
import 'package:iwg_proyect/page1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Welcome to Flutter',

      home: FirstRoute(),

    );
  }
}