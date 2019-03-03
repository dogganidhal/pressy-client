import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class PaymentMethodsWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _PaymentMethodsWidgetState();

}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 1,
        iconTheme: new IconThemeData(color: ColorPalette.orange),
        title: new Text("Mes moyens de paiment"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
    );
  }

}