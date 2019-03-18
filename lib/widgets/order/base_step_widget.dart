import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class BaseStepWidget extends StatefulWidget {

  final String title;
  final Widget child;

  const BaseStepWidget({Key key, this.title, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _BaseStepWidgetState();

}

class _BaseStepWidgetState extends State<BaseStepWidget> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(12),
      decoration: new BoxDecoration(
          border: new Border.all(color: ColorPalette.borderGray, width: 1.0),
          borderRadius: new BorderRadius.circular(4)
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(12),
            child: new Text(
              this.widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textBlack
              ),
            ),
          ),
          new Divider(),
          new SizedBox(height: 12),
          this.widget.child
        ],
      ),
    );
  }

}