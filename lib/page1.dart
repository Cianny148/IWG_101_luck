import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:iwg_proyect/page2.dart';
import 'package:iwg_proyect/page3.dart';
import 'package:iwg_proyect/settingsPage.dart';
import 'package:iwg_proyect/animacion.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'dart:ui';

import 'package:iwg_proyect/main.dart';

import 'main.dart';

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MaterialApp(
            theme: temazo,
            home: Scaffold(
              drawerEnableOpenDragGesture: true,
              drawer: Drawer(
                  child: Container(
                child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[200], Colors.blue[800]]),
                    ),
                    child: Container(
                      child: Text('Only Draws?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'IndieFlower',
                            fontSize: 60.0,
                          )),
                      transform: Matrix4.rotationZ(-0.25),
                    ),
                  ),
                  ListTile(
                    title: Text('Dibujar'),
                    tileColor: Colors.white10,
                    onTap: () async {
                      cont = await getContador();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => SecondRoute()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Galeria'),
                    tileColor: Colors.white10,
                    onTap: () async {
                      ids = await getFilesPath();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ThirdRoute()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Settings'),
                    tileColor: Colors.white10,
                    onTap: () {
                      setState(() {});
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Settings()));
                    },
                  ),
                ]),
              )),

//Barra superior--------------------------------------------
              appBar: AppBar(
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
                      child: Center(
                          child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: AssetImage('icons/New_Drawing.png'),
                    child: Circle_prog({}),
                  ))),

                  Container(
                    child: Text('Only Draws?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'IndieFlower',
                            fontSize: 60.0,
                            color: Colors.black)),
                    transform: Matrix4.rotationZ(-0.25),
                  ),

//----------------------------------------------------------------------------------------
                  new AnimatedContainer(
                    alignment: Alignment.center,
                    height: 130,
                    width: 325,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(color: temazo.accentColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: ColorizeAnimatedTextKit(
                      repeatForever: true,
                      text: ['El', 'tema', 'de', 'hoy', 'es', '$titulo'],
                      textStyle: TextStyle(
                          fontSize: 70.0,
                          fontFamily: 'IndieFlower',
                          fontWeight: FontWeight.w900),
                      colors: [
                        Colors.purple,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),

//----------------------------------------------------------------------------------------
                  Container(
                    child: FlatButton(
                      onPressed: () async {
                        cont = await getContador();
                        Navigator.push(
                            context,
                            new PageRouteBuilder(
                                transitionDuration: Duration(seconds: 1),
                                transitionsBuilder:
                                    (context, animation, animationTime, child) {
                                  animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.elasticInOut);
                                  return ScaleTransition(
                                    alignment: Alignment.center,
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animtation, animationTime) {
                                  return SecondRoute();
                                }));
                      },
                      child: Text(
                        'A Dibujar!!',
                        style: TextStyle(
                          fontFamily: 'IndieFlower',
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: temazo.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),

//-------------------------------------------------------------------------
                  Container(
                    child: FlatButton(
                      onPressed: () async {
                        ids = await getFilesPath();
                        Navigator.push(
                            context,
                            new PageRouteBuilder(
                                transitionDuration: Duration(seconds: 1),
                                transitionsBuilder:
                                    (context, animation, animationTime, child) {
                                  animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.elasticInOut);
                                  return ScaleTransition(
                                    alignment: Alignment.center,
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animtation, animationTime) {
                                  return ThirdRoute();
                                }));
                      },
                      child: Text(
                        'Galeria',
                        style: TextStyle(
                          fontFamily: 'IndieFlower',
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: temazo.primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
//-------------------------------------------------------------------------------
                ],
              )),
            )),
        onWillPop: () async => false);
  }
}
