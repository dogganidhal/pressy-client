import 'package:flutter/material.dart';

mixin LoaderMixin {

  void showLoaderSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 12),
          Text("CHARGEMENT...")
        ],
      ),
      duration: Duration(minutes: 1)
    ));
  }

  void hideLoaderSnackBar(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }

}