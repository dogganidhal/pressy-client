import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';
import 'package:intl/intl.dart';


class SlotWidget extends StatefulWidget {

  final String title;
  final List<Slot> slots;

  SlotWidget({Key key, @required this.title, @required this.slots}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SlotWidgetState();

}

class _SlotWidgetState extends State<SlotWidget> {

  DateFormat _dateFormat = new DateFormat("EEEE dd MMM HH'h'mm");
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: this.widget.title,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new CupertinoSegmentedControl<int>(
            borderColor: ColorPalette.orange,
            selectedColor: ColorPalette.orange,
            unselectedColor: Colors.white,
            groupValue: this._selectedIndex,
            children: {
              0: new Text("Standard"),
              1: new Text("VIP")
            },
            onValueChanged: (index) => this.setState(() => this._selectedIndex = index)
          ),
          new SizedBox(height: 24),
          this._slotInformationWidget(this._selectedIndex == 0 ? SlotType.STANDARD : SlotType.VIP)
        ],
      ),
    );
  }

  Widget _slotInformationWidget(SlotType slotType) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Text("• Créneau de : ", style: new TextStyle(color: ColorPalette.textGray)),
            new Text("30 minutes", style: new TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        new SizedBox(height: 8),
        new Row(
          children: <Widget>[
            new Text("• Frais de service : ", style: new TextStyle(color: ColorPalette.textGray)),
            new Text(slotType == SlotType.STANDARD ? "GRATUIT" : "3.99€", style: new TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        new SizedBox(height: 8),
        new Row(
          children: <Widget>[
            new Text("• Frais de service : ", style: new TextStyle(color: ColorPalette.textGray)),
            new Text(slotType == SlotType.STANDARD ? "48h" : "24h", style: new TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        new SizedBox(height: 48),
        new SizedBox(
          height: 124,
          child: this._slotListWidget,
        ),
        new SizedBox(height: 48),
      ],
    );
  }

  Widget get _slotListWidget => new Container(
    child: new ListWheelScrollView.useDelegate(
      itemExtent: Theme.of(context).textTheme.display2.fontSize,
      childDelegate: new ListWheelChildBuilderDelegate(
        childCount: 10,
        builder: (context, index) => new Text(
          this._dateFormat.format(DateTime.now()),
          style: new TextStyle(color: ColorPalette.textGray, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      onSelectedItemChanged: (index) => print("Selected $index"),
      useMagnifier: true,
      renderChildrenOutsideViewport: true,
      clipToSize: false,
    ),
  );

}