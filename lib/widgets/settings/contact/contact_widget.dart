import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class ContactWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        title: Text("Nous contacter"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Text(
          'Pour nous contacter  : \n'
          'Par mail : contact@pressy.app\n'
          'Par téléphone :\n' 
          '01 87 66 88 63\n'
          'De 6h30 - 10h00\n'
          'Et de 19h00 -23h\n',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        ),
      ),
    );
  }

}