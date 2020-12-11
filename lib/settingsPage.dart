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
                ListTile(title: Text('Opcion 1')),
                Divider(
                  color: Colors.black,
                ),
                CheckboxListTile(
                  value: opcion1,
                  title: Text("Mostrar tema al dibujar"),
                  subtitle: Text('temas seleccionados al azar en ingles'),
                  onChanged: (value) {
                    setState((){
                      cambiarSettingsOne();
                      cambiarTitulo(!opcion1);
                    });
                  },
                ),
                ListTile(
                  title: Text("Generar Nuevo Tema"),
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
                ListTile(title: Text('Opcion 2')),
                Divider(
                  color: Colors.black,
                ),
                CheckboxListTile(
                  value: opcion2,
                  title: Text("CheckBox"),
                  onChanged: (value) {},
                ),
                Container(
                )
              ],
            )));
  }
}
