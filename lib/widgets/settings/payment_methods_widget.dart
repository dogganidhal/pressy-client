import 'package:flutter/material.dart';


class PaymentMethodsWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _PaymentMethodsWidgetState();

}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Mes moyens de paiment"),
        backgroundColor: Colors.white,
      ),
    );
  }

}