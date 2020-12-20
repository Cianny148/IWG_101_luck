import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:iwg_proyect/page1.dart';
import 'package:random_color/random_color.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iwg_proyect/temas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  titulo = await getTitulo();
  runApp(MyApp());

  Directory appDocDir = await getExternalStorageDirectory();
  appDocPath = appDocDir.path;
  print(appDocPath);
  neoFecha = await getFecha();
  opcion1 = await getSettingsOne();
  cont = await getContador();
  titulo = await getTitulo();
  ids = await getFilesPath();
  if (neoFecha != fecha) {
    titulo = await setTitulo(pickWord());
    setFecha(fecha);
    setContador(1);
  }
  cambiarTitulo(opcion1);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: FirstRoute(),
    );
  }
}

//Generar Colores nuevos---------------------------------------------------------------------------------------------
var hoy = new DateTime.now();
var dia = hoy.day.toInt();
var mes = hoy.month.toInt();
var ano = hoy.year.toInt();
int fecha = int.parse('$ano' + '$mes' + '$dia');
int neoFecha;

List<Color> dailyColor(seed) {
  List<Color> colores = RandomColor(seed).randomColors(
      count: 10,
      colorHue: ColorHue.random,
      colorBrightness: ColorBrightness.random,
      colorSaturation: ColorSaturation.random);
  colores.add(Colors.black);
  colores.add(Colors.white);
  return colores;
}

List<Color> selectedColors = dailyColor(neoFecha);

//Pedir permisos de almacenamiento---------------------------------------------------------------------------------------------
pedir() async {
  var storagestatus = await Permission.storage.status;

  if (storagestatus.isUndetermined) {
    await Permission.storage.request();
  }
}

//Guardar Imagen----------------------------------------------------------------------------------------------------------
Image dibujo;
List<String> ids = [];
Future<void> save(img) async {
  Uint8List pngBytes = await img.toPNG();
  new File(appDocPath +
          '/' +
          '$dia' +
          '-' +
          '$mes' +
          '-' +
          '$ano' +
          '-' +
          '$cont' +
          '.jpg')
      .writeAsBytes(pngBytes);
  ids.add('/' + '$dia' + '-' + '$mes' + '-' + '$ano' + '-' + '$cont' + '.jpg');
  await setFilesPath(ids);
  ids = await getFilesPath();
  ImageGallerySaver.saveImage(
    pngBytes,
    quality: 90,
    name: '$dia' + '-' + '$mes' + '-' + '$ano' + '-' + '$cont',
  );
}

int cont;
List listaGuardada;
String appDocPath;
String appImg = '/storage/emulated/0/iwg_proyect';
//settings---------------------------------------------------------------------------------------------------------------7
bool opcion1;
bool opcion2 = true;
String titulo;
String defaultTitle = 'Nuevo Lienzo';

cambiarTitulo(bool value) async {
  if (value) {
    titulo = await getTitulo();
  } else {
    titulo = defaultTitle;
  }
}

cambiarSettingsOne() async {
  setSettingsOne(!opcion1);
  opcion1 = await getSettingsOne();
}

getSettingsOne() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool settingsOne = prefs.getBool('settingsOne') ?? true;
  return settingsOne;
}

setSettingsOne(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool settingsOne = prefs.getBool('settingsOne') ?? true;
  await prefs.setBool('settingsOne', value);
}

getTitulo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String titulo = prefs.getString('dynamicTitle') ?? 'Nuevo Lienzo';
  return titulo;
}

setTitulo(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String titulo = prefs.getString('dynamicTitle');
  await prefs.setString('dynamicTitle', value);
}

getFecha() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int fecha = prefs.getInt('dynamicDate') ?? 0;
  return fecha;
}

setFecha(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int fecha = prefs.getInt('dynamicDate');
  await prefs.setInt('dynamicDate', value);
}

getContador() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int cont = prefs.getInt('dynamicCont') ?? 1;
  return cont;
}

setContador(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int cont = prefs.getInt('dynamicCont');
  await prefs.setInt('dynamicCont', value);
}

getFilesPath() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> path = prefs.getStringList('FilePath') ?? [];
  return path;
}

setFilesPath(List<String> value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> path = prefs.getStringList('FilePath');
  await prefs.setStringList('FilePath', value);
}
