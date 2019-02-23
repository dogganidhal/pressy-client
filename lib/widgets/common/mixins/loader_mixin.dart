import 'package:flutter/material.dart';

mixin LoaderMixin {

  void showLoaderSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new SizedBox(width: 12),
          new Text("CHARGEMENT...")
        ],
      ),
      duration: new Duration(minutes: 1)
    ));
  }

  void hideLoaderSnackBar(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }

}