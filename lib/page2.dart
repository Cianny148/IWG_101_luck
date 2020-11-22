import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';

void main() => runApp(new SecondRoute());

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Nuevo Lienzo',
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
          title: const Text('Nuevo Dibujo'),
          actions: actions,
          bottom: new PreferredSize(
            child: new DrawBar(_controller),
            preferredSize: new Size(MediaQuery.of(context).size.width, 25.0),
          )),
      body: new Center(
          child: new AspectRatio(
              aspectRatio: 0.71, child: new Painter(_controller))),
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
          child: ButtonBar(
            alignment:MainAxisAlignment.center,
            children: <Widget>[
            ElevatedButton(onPressed: null, child: Text('Compartir')),
            ElevatedButton(onPressed: null, child: Text('Guardar'))]),
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