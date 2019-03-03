import 'package:flutter/material.dart';


class ResetPasswordWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ResetPasswordWidgetState();

}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Nouveau mot de passe"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
    );
  }

}