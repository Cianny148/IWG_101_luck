import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iwg_proyect/main.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Galeria local'),
          centerTitle: true,
        ),
        body: Gallery());
  }
}

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool loading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            child: Image.file(File(appDocPath + '${ids[index]}')),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ImagePage(ids[index]);
            }));
          },
        );
      },
      itemCount: ids.length,
    );
  }
}

class ImagePage extends StatelessWidget {
  final String id;
  ImagePage(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Image.file(File(appDocPath + '$id')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: ()async{
          final bytes = await File(appDocPath + '$id').readAsBytes();
          Share.file("Titulo", 'Dibujo.png', bytes, "images/png");
        },
      ),
    );
  }
}
