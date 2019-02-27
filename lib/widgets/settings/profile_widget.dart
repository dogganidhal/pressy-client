import 'package:flutter/material.dart';


class ProfileWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ProfileWidgetState();

}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mon Profil"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
    );
  }

}