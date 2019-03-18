import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';


class EstimateOrderStepWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _EstimateOrderStepWidgetState();

}

class _EstimateOrderStepWidgetState extends State<EstimateOrderStepWidget> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: "Estimer votre commande",
      child: new CupertinoSegmentedControl<int>(
          borderColor: ColorPalette.orange,
          selectedColor: ColorPalette.orange,
          unselectedColor: Colors.white,
          groupValue: this._selectedIndex,
          children: {
            0: new Text("Pressing"),
            1: new Text("Linge au kilo")
          },
          onValueChanged: (index) => this.setState(() => this._selectedIndex = index)
      ),
    );
  }

}