import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Application extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pressy',
      theme: new ThemeData(primarySwatch: Colors.blue,
      ),
      home: new Container(),
    );
  }

}