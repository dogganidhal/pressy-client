import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class BaseStepWidget extends StatefulWidget {

  final String title;
  final Widget child;

  const BaseStepWidget({Key key, this.title, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BaseStepWidgetState();

}

class _BaseStepWidgetState extends State<BaseStepWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: ColorPalette.borderGray, width: 1.0),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            child: Text(
              this.widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textBlack
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 12),
          this.widget.child
        ],
      ),
    );
  }

}