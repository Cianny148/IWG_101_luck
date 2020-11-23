import 'package:flutter/material.dart';
import 'package:iwg_proyect/page2.dart';
import 'package:iwg_proyect/page3.dart';
import 'package:iwg_proyect/settingsPage.dart';
import 'package:iwg_proyect/main.dart';

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
                gradient: LinearGradient(
                    colors: [Colors.blue[200], Colors.blue[800]]),
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
            title: Text('Dibujar'),
            tileColor: Colors.white10,
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => SecondRoute()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Galeria'),
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
          ListTile(
            title: Text('color'),
            tileColor: selectedColors.elementAt(7),
          )
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
        children: <Widget>[
//###################### Widgets en columna #######################

//Imagen avatar redonda-------------------------------------------------------
          Container(
              child: CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage('icons/New_Drawing.png'),
          )),

          Container(
            child: Text('Only Draws?',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'IndieFlower',
                  fontSize: 60.0,
                )),
            transform: Matrix4.rotationZ(-0.25),
          ),
//----------------------------------------------------------------------------------------
          Container(
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => SecondRoute()));
              },
              child: Text(
                'A Dibujar!!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'IndieFlower',
                  fontSize: 40.0,
                ),
              ),
            ),
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.blue[600],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
//-------------------------------------------------------------------------
          Container(
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => ThirdRoute()));
              },
              child: Text(
                'Galeria',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'IndieFlower',
                  fontSize: 30.0,
                ),
              ),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.blue[800],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(40))),
          ),
//-------------------------------------------------------------------------------
        ],
      )),
    );
  }
}
