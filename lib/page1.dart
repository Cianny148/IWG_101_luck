import 'package:flutter/material.dart';
import 'package:iwg_proyect/page2.dart';
import 'package:iwg_proyect/page3.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
//Barra superior--------------------------------------------
      /*appBar: AppBar(
        title: Text('Only Draws?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
        ),
        ),
        backgroundColor: Colors.indigo,
      ),*/
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
              padding: EdgeInsets.fromLTRB(0, 50, 0, 200),
                child: CircleAvatar(
                  radius: 90.0,
                  backgroundImage: AssetImage('icons/New_Drawing.png'),
              )
            ),

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
                Navigator.push(context, new MaterialPageRoute(builder: (context) => SecondRoute()));
              },
//Child del boton---------------
              child: Card(
              margin: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 15.0,
              ),
              child: Text('A Dibujar!!',
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
                Navigator.push(context, new MaterialPageRoute(builder: (context) => ThirdRoute()));
              },
//Child del boton---------------
              child: Card(
              margin: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 5.0,
              ),
              child: Text('Galería',
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
        )
      ),
    );
  }
}