import 'package:flutter/material.dart';

import 'package:iwg_proyect/main.dart';
import 'package:iwg_proyect/temas.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configuracion'),
          centerTitle: true,
          backgroundColor: Colors.blue[600],
        ),
        body: Container(
            color: Colors.blue[200],
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
                    setState((){
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
                      if (opcion1){
                        setTitulo(pickWord());
                        cambiarTitulo(opcion1);
                      }
                    });
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            )));
  }
}
