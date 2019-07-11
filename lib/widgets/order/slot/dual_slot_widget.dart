import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pressy_client/data/model/order/slot/slot.dart';

class DualSlotWidget extends StatefulWidget {
  final List<Slot> slots;

  const DualSlotWidget({Key key, @required this.slots}) : super(key: key);
  @override
  _DualSlotWidgetState createState() => _DualSlotWidgetState();
}

class _DualSlotWidgetState extends State<DualSlotWidget> {
  //DateFormat _dateFormat = DateFormat("EEEE dd MMM HH'h'mm", "fr");
  DateFormat _dateFormat = DateFormat("EEEE dd MMM");
  DateFormat _timeFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 100,
            height: Theme.of(context).textTheme.display2.fontSize + 60,
            child: CupertinoPicker(
              backgroundColor: Colors.transparent,
              onSelectedItemChanged: (int value) {},
              useMagnifier: true,
              itemExtent: Theme.of(context).textTheme.display2.fontSize + 5,
              magnification: 1.2,
              children: this
                  .widget
                  .slots
                  .map((slot) => Container(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(this._dateFormat.format(slot.startDate)),
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            width: 200,
            height: Theme.of(context).textTheme.display2.fontSize + 60,
            child: CupertinoPicker(
              backgroundColor: Colors.transparent,
              onSelectedItemChanged: (int value) {},
              useMagnifier: true,
              itemExtent: Theme.of(context).textTheme.display2.fontSize + 5,
              magnification: 1.2,
              children: this
                  .widget
                  .slots
                  .map((slot) => Container(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "${this._timeFormat.format(slot.startDate)}  -  ${this._timeFormat.format(slot.startDate.add(Duration(minutes: 30)))}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
