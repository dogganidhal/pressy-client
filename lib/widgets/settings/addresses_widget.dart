import 'package:flutter/material.dart';


class AddressesWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _AddressesWidgetState();

}

class _AddressesWidgetState extends State<AddressesWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mes adresses"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
    );
  }

}