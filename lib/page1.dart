import 'package:flutter/material.dart';
import 'package:iwg_proyect/page2.dart';
import 'package:iwg_proyect/page3.dart';
import 'package:iwg_proyect/settingsPage.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(
          child: Container(
        color: Colors.blue[100],
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blue[200], Colors.teal]),
              ),
              child: Column(children: [
                DrawerHeader(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('icons/no_user.png'),
                    radius: 80,
                  ),
                ),
                ElevatedButton(onPressed: null, child: Text('Login'))
              ])),
          ListTile(
            title: Text('Boton 1'),
            tileColor: Colors.white10,
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => SecondRoute()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Boton 2'),
            tileColor: Colors.white10,
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => ThirdRoute()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Settings'),
            tileColor: Colors.white10,
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => FourthRoute()));
            },
          ),
        ]),
      )),

      backgroundColor: Colors.blue[200],
//Barra superior--------------------------------------------
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        shadowColor: Colors.white10,
      ),
//---------------------------------------------------------

//cuerpo principal de la pagina-------------------------
      body: Center(
//widget columna--------------------------------------------
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//###################### Widgets en columna #######################

//Imagen avatar redonda-------------------------------------------------------
          Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 100),
              child: CircleAvatar(
                radius: 90.0,
                backgroundImage: AssetImage('icons/New_Drawing.png'),
              )),

          Text('Only Draws?',
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'IndieFlower',
                fontSize: 60.0,
              )),
//Boton de prueba------------------------------------------------------------------
//            ElevatedButton(
//Funcion del boton------------------
//              onPressed: () {
//                Navigator.push(context, new MaterialPageRoute(builder: (context) => ThirdRoute()));
//              }, child: Text('Pagina 3'),
//            ),

//Boton-------------------------------------------------------------------
          FlatButton(
//Funcion del boton------------
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => SecondRoute()));
            },
//Child del boton---------------
            child: Card(
              margin: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 15.0,
              ),
              child: Text(
                'A Dibujar!!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'IndieFlower',
                  fontSize: 40.0,
                ),
              ),
              color: Colors.indigo,
              shadowColor: Colors.orange,
            ),
          ),
//-------------------------------------------------------------------

//Boton-------------------------------------------------------------------
          FlatButton(
//Funcion del boton------------
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => ThirdRoute()));
            },
//Child del boton---------------
            child: Card(
              margin: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 5.0,
              ),
              child: Text(
                'Galería',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'IndieFlower',
                  fontSize: 40.0,
                ),
              ),
              color: Colors.indigo,
              shadowColor: Colors.orange,
            ),
          ),
//-------------------------------------------------------------------
        ],
      )),
    );
  }
}
