import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class NumericStepper extends StatefulWidget {

  final ValueChanged<int> onValueChanged;

  const NumericStepper({Key key, this.onValueChanged}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _NumericStepperState();

}

class _NumericStepperState extends State<NumericStepper> {

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(4),
        border: new Border.all(color: ColorPalette.orange, width: 1)
      ),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            width: 32, height: 32,
            color: ColorPalette.orange,
            child: new Center(
              child: new ButtonTheme(
                height: 18,
                child: new IconButton(
                  icon: Icon(Icons.remove, size: 18, color: Colors.white),
                  onPressed: this._value > 0 ? this._subtract : null
                )
              )
            ),
          ),
          new Container(
            width: 32, height: 32,
            color: Colors.transparent,
            child: new Center(
              child: new Text("${this._value}")
            ),
          ),
          new Container(
            width: 32, height: 32,
            color: ColorPalette.orange,
            child: new Center(
              child: new ButtonTheme(
                height: 18,
                child: new IconButton(
                  icon: Icon(Icons.add, size: 18, color: Colors.white),
                  onPressed: this._add
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  void _add() => this.setState(() {
    this._value++;
    this.widget.onValueChanged(this._value);
  });

  void _subtract() => this.setState(() {
    this._value--;
    this.widget.onValueChanged(this._value);
  });

}