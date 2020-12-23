import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iwg_proyect/page1.dart';
import 'package:iwg_proyect/temas.dart';

import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  titulo = await getTitulo();
  tema1 = await getTemaOne();
  tema2 = await getTemaTwo();
  tema3 = await getTemaThree();
  if (tema1){
    temazo = miTema;
  }
  if (tema2){
    temazo = tuTema;
  }
  if (tema3){
    temazo = suTema;
  }
  runApp(MyApp());

  Directory appDocDir = await getExternalStorageDirectory();
  appDocPath = appDocDir.path;

  neoFecha = await getFecha();
  opcion1 = await getSettingsOne();

  if (neoFecha != fecha) {
    titulo = await setTitulo(pickWord());
    setFecha(fecha);
    setContador(1);
  }

  cambiarTitulo(opcion1);
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'WelcomeScreen',
      home: FirstRoute(),
    );
  }
}

ThemeData temazo;

ThemeData miTema = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.red[800],
  accentColor: Colors.redAccent,
);
ThemeData tuTema = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green[800],
  accentColor: Colors.yellowAccent,
);
ThemeData suTema = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.indigo[800],
  accentColor: Colors.deepPurpleAccent,
);
bool tema1;
bool tema2;
bool tema3;
//Generar Colores nuevos---------------------------------------------------------------------------------------------
var hoy = new DateTime.now();

var dia = hoy.day.toInt();
var mes = hoy.month.toInt();
var ano = hoy.year.toInt();
int fecha = int.parse('$ano' + '$mes' + '$dia');
int neoFecha;


//Guardar Imagen----------------------------------------------------------------------------------------------------------
int cont;
String appDocPath;
List<String> ids = [];

//settings---------------------------------------------------------------------------------------------------------------7
bool opcion1;
bool temazo1;
bool temazo2;
bool temazo3;
String titulo;
String defaultTittle = 'Nuevo Lienzo';

cambiarTitulo(bool value) async {
  if (value) {
    titulo = await getTitulo();
  } else {
    titulo = defaultTittle;
  }
}

cambiarSettingsOne() async {
  setSettingsOne(!opcion1);
  opcion1 = !opcion1;
}

getSettingsOne() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool settingsOne = prefs.getBool('settingsOne') ?? true;
  return settingsOne;
}

setSettingsOne(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('settingsOne', value);
}

getTitulo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String titulo = prefs.getString('dynamicTitle') ?? 'Nuevo Lienzo';
  return titulo;
}

setTitulo(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('dynamicTitle', value);
}

getFecha() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int fecha = prefs.getInt('dynamicDate') ?? 0;
  return fecha;
}

setFecha(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('dynamicDate', value);
}

getContador() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int cont = prefs.getInt('dynamicCont') ?? 1;
  return cont;
}

setContador(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('dynamicCont', value);
}

getFilesPath() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> path = prefs.getStringList('FilePath') ?? [];
  return path;
}

setFilesPath(List<String> value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('FilePath', value);
}

getTemaOne() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool settingsOne = prefs.getBool('temaOne') ?? true;
  return settingsOne;
}

setTemaOne(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('temaOne', value);
}

getTemaTwo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool settingsOne = prefs.getBool('temaTwo') ?? false;
  return settingsOne;
}

setTemaTwo(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('temaTwo', value);
}

getTemaThree() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool settingsOne = prefs.getBool('temaThree') ?? false;
  return settingsOne;
}

setTemaThree(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('temaThree', value);
}