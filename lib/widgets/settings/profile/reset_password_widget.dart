import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class ResetPasswordWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ResetPasswordWidgetState();

}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        title: Text("Nouveau mot de passe"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
    );
  }

}