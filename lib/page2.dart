import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:random_color/random_color.dart';
import 'package:painter/painter.dart';

import 'package:iwg_proyect/main.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

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

pedir() async {
  var storagestatus = await Permission.storage.status;

  if (storagestatus.isUndetermined) {
    await Permission.storage.request();
  }
}

Future<void> save(img) async {
  Uint8List pngBytes = await img.toPNG();
  new File(appDocPath +'/'+'$dia'+'-'+'$mes'+'-'+'$ano'+'-'+'$cont'+'.jpg').writeAsBytes(pngBytes);
  ids.add('/'+'$dia'+'-'+'$mes'+'-'+'$ano'+'-'+'$cont'+'.jpg');
  await setFilesPath(ids);
  ids=await getFilesPath();
  ImageGallerySaver.saveImage(
    pngBytes,
    quality: 90,
    name: '$dia'+'-'+'$mes'+'-'+'$ano'+'-'+'$cont',
  );
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '$titulo',
      home: new ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool _finished;
  PainterController _controller;

  @override
  void initState() {
    super.initState();
    _finished = false;
    _controller = _newController();
  }

  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 4.0;
    controller.backgroundColor = Colors.white;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        new IconButton(
          icon: new Icon(Icons.content_copy),
          tooltip: 'Nuevo Dibujo',
          onPressed: () => setState(() {
            _finished = false;
            _controller = _newController();
          }),
        ),
      ];
    } else {
      actions = <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.undo,
            ),
            tooltip: 'Deshacer',
            onPressed: () {
              if (_controller.isEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        new Text('Nada que Deshacer'));
              } else {
                _controller.undo();
              }
            }),
        new IconButton(
            icon: new Icon(Icons.delete),
            tooltip: 'Clear',
            onPressed: _controller.clear),
        new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => _show(_controller.finish(), context)),
      ];
    }
    return new Scaffold(
      appBar: new AppBar(
          title: Text('$titulo'),
          actions: actions,
          bottom: new PreferredSize(
            child: new DrawBar(_controller),
            preferredSize: new Size(MediaQuery.of(context).size.width, 25.0),
          )),
      body: new Center(
          child: new AspectRatio(
              aspectRatio: 0.71 , child: new Painter(_controller))),
    );
  }

  void _show(PictureDetails picture, BuildContext context) {
    setState(() {
      _finished = true;
    });
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: const Text('Que deseas hacer con el dibujo?'),
        ),
        //---------------------------------------------------
        bottomNavigationBar: BottomAppBar(
          child:
              ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  final Uint8List pngBytes = await picture.toPNG();
                  Share.file("Titulo", '$dia'+'-'+'$mes'+'-'+'$ano'+'-'+'$cont'+'.png', pngBytes, "images/png");
                },
                child: Text('Compartir')),
            ElevatedButton(
                onPressed: () async {
                  await pedir();
                  await save(picture);
                  Navigator.pop(context);
                  await setContador(cont+=1);
                },
                child: Text('Guardar'))
          ]),
          color: Colors.blue,
        ),
        //---------------------------------------
        body: new Container(
            alignment: Alignment.center,
            child: new FutureBuilder<Uint8List>(
              future: picture.toPNG(),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return Image.memory(snapshot.data);
                    }
                    break;
                  default:
                    return new Container(
                        child: new FractionallySizedBox(
                      widthFactor: 0.1,
                      child: new AspectRatio(
                          aspectRatio: 1.0,
                          child: new CircularProgressIndicator()),
                      alignment: Alignment.center,
                    ));
                }
              },
            )),
      );
    }));
  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(child: new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new Container(
              child: new Slider(
            value: _controller.thickness,
            onChanged: (double value) => setState(() {
              _controller.thickness = value;
            }),
            min: 1.0,
            max: 20.0,
            activeColor: Colors.white,
          ));
        })),
        new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new RotatedBox(
              quarterTurns: _controller.eraseMode ? 2 : 0,
              child: IconButton(
                  icon: new Icon(Icons.create),
                  tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                      ' eraser',
                  onPressed: () {
                    setState(() {
                      _controller.eraseMode = !_controller.eraseMode;
                    });
                  }));
        }),
        new ColorPickerButton(_controller, false),
        new ColorPickerButton(_controller, true),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => new _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                  appBar: new AppBar(
                    title: const Text('Elige un color'),
                  ),
                  body: new Container(
                      alignment: Alignment.center,
                      child: new BlockPicker(
                        //aqui se usa la lista de colores
                        availableColors: selectedColors,
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
