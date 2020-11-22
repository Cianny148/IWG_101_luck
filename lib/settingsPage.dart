import 'package:flutter/material.dart';

class FourthRoute extends StatelessWidget {
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
            Divider(color: Colors.black,),
            CheckboxListTile(
              value: true,
              title: Text("CheckBox"),
              onChanged: (value) {},
            ),
            SwitchListTile(
              value: false,
              title: Text("Switch"),
              onChanged: (value) {},
            ),
            Divider(color: Colors.black,),
            ListTile(title: Text('Opcion 2')),
            Divider(color: Colors.black,),
            CheckboxListTile(
              value: true,
              title: Text("CheckBox"),
              onChanged: (value) {},
            ),
            SwitchListTile(
              value: false,
              title: Text("Switch"),
              onChanged: (value) {},
            ),
          ],
        )));
  }
}
