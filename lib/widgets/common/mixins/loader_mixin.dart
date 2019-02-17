import 'package:flutter/material.dart';
import 'package:pressy_client/widgets/common/layouts/loader_widget.dart';

mixin LoaderMixin {

  void showLoader(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text("CHARGEMENT...")
        ],
      ),
      duration: new Duration(minutes: 1)
    ));
  }

  void hideLoader(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }

}