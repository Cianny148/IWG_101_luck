import 'package:flutter/material.dart';
import 'package:iwg_proyect/page1.dart';
import 'package:iwg_proyect/page2.dart';

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 3'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Pagina 1'),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => FirstRoute()
            ));
          },
        ),
      ),
    );
  }
}