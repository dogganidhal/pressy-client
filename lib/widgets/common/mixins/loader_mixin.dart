import 'package:flutter/material.dart';

mixin LoaderMixin {
  void showLoaderSnackBar(BuildContext context,
      {String loaderText,
      bool showLoadingProgressBar = true,
      int durationInSec}) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLoadingProgressBar
                  ? CircularProgressIndicator()
                  : Container(),
              SizedBox(width: 12),
              Flexible(child: Text(loaderText ?? "CHARGEMENT..."))
            ],
          ),
        ),
        duration: durationInSec == null
            ? Duration(minutes: 1)
            : Duration(seconds: durationInSec)));
  }

  void hideLoaderSnackBar(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }
}
