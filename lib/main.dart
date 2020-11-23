import 'package:flutter/material.dart';
import 'package:iwg_proyect/page1.dart';
import 'package:random_color/random_color.dart';

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

var hoy = new DateTime.now();
var dia_ = hoy.day.toInt();
var mes_ = hoy.month.toInt();
var ano_ = hoy.year.toInt();

List<Color> dailyColor(seed){
  final List <Color> colores = RandomColor(seed).randomColors(count: 8,colorHue: ColorHue.random,colorBrightness: ColorBrightness.random,colorSaturation: ColorSaturation.random);
  return colores;
}

List<Color>selectedColors = dailyColor(dia_);