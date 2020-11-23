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
//para usar las funciones y variables creadas en esta pagina dentro del codigo de otra se escribe import'package:iwg_proyect/main.dart'

// aqui se obtienen los datos de la fecha
var hoy = new DateTime.now();

// se separan en variables a parte
var dia_ = hoy.day.toInt();
var mes_ = hoy.month.toInt();
var ano_ = hoy.year.toInt();

//crea una lista de largo modificable con colores creados al azar en base a la semilla seed
List<Color> dailyColor(seed){
  final List <Color> colores = RandomColor(seed).randomColors(count: 8,colorHue: ColorHue.random,colorBrightness: ColorBrightness.random,colorSaturation: ColorSaturation.random);
  return colores;
}
//Lista de colores creada en base al dia por ahora 
List<Color>selectedColors = dailyColor(dia_);