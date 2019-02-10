import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LoaderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.25],
          colors: [
            Colors.black.withAlpha((255 * 0.9).toInt()),
            Colors.black.withAlpha((255 * 0.75).toInt())
          ]
        )
      ),
      child: new Center(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new SizedBox(width: 36),
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(8),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(8),
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new SizedBox(height: 8),
                    new CircularProgressIndicator(),
                    new SizedBox(height: 16),
                    new Text(
                      "CHARGEMENT",
                      style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 14, color: Colors.grey)
                    ),
                    new SizedBox(height: 8)
                  ],
                ),
              )
            ),
            new SizedBox(width: 36),
          ],
        )
      ),
    );
  }

}