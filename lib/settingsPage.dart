import 'package:flutter/material.dart';

import 'package:iwg_proyect/main.dart';
import 'package:iwg_proyect/page1.dart';
import 'package:iwg_proyect/temas.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MaterialApp(
          theme: temazo,
          home: Scaffold(
              appBar: AppBar(
                title: Text('Configuracion'),
                centerTitle: true,
              ),
              body: Container(
                  child: ListView(
                children: [
                  ListTile(title: Text('Ideas')),
                  Divider(
                    color: Colors.black,
                  ),
                  CheckboxListTile(
                    value: opcion1,
                    title: Text("Mostrar tema al dibujar"),
                    subtitle: Text('temas seleccionados al azar'),
                    onChanged: (value) {
                      setState(() {
                        cambiarSettingsOne();
                        cambiarTitulo(opcion1);
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Generar Nuevo tema"),
                    subtitle: Text('$titulo'),
                    onTap: () {
                      setState(() {
                        if (opcion1) {
                          setTitulo(pickWord());
                          cambiarTitulo(opcion1);
                        }
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          child: Text('Tema 1'),
                          onPressed: () async {
                            await setTemaOne(true);
                            await setTemaTwo(false);
                            await setTemaThree(false);
                            setState(() {
                              temazo = miTema;
                            });
                          }),
                      ElevatedButton(
                          child: Text('Tema 2'),
                          onPressed: () async {
                            await setTemaOne(false);
                            await setTemaTwo(true);
                            await setTemaThree(false);
                            setState(() {
                              temazo = tuTema;
                            });
                          }),
                      ElevatedButton(
                          child: Text('Tema 3'),
                          onPressed: () async {
                            await setTemaOne(false);
                            await setTemaTwo(false);
                            await setTemaThree(true);
                            setState(() {
                              temazo = suTema;
                            });
                          }),
                    ],
                  )
                ],
              ))),
        ),
        onWillPop: () {
          return Navigator.push(context,
              new MaterialPageRoute(builder: (context) => FirstRoute()));
        });
  }
}
