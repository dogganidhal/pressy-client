import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class NumericStepper extends StatefulWidget {

  final ValueChanged<int> onValueChanged;

  const NumericStepper({Key key, this.onValueChanged}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumericStepperState();

}

class _NumericStepperState extends State<NumericStepper> {

  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: ColorPalette.orange, width: 1)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 32, height: 32,
            color: ColorPalette.orange,
            child: Center(
              child: ButtonTheme(
                height: 18,
                child: IconButton(
                  icon: Icon(Icons.remove, size: 18, color: Colors.white),
                  onPressed: this._value > 0 ? this._subtract : null
                )
              )
            ),
          ),
          Container(
            width: 32, height: 32,
            color: Colors.transparent,
            child: Center(
              child: Text("${this._value}")
            ),
          ),
          Container(
            width: 32, height: 32,
            color: ColorPalette.orange,
            child: Center(
              child: ButtonTheme(
                height: 18,
                child: IconButton(
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