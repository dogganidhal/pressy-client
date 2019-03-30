import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';
import 'package:intl/intl.dart';


typedef void SlotSelectedCallback(Slot slot);


class SlotWidget extends StatefulWidget {

  final String title;
  final bool isLoading;
  final List<Slot> slots;
  final SlotSelectedCallback onSlotSelected;
  final VoidCallback onSlotConfirmed;
  final bool canMoveForward;

  SlotWidget({
    Key key, @required this.title,
    @required this.onSlotSelected,
    @required this.onSlotConfirmed,
    this.canMoveForward = false,
    this.slots = const [], this.isLoading = true
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SlotWidgetState();

}

class _SlotWidgetState extends State<SlotWidget> {

  DateFormat _dateFormat = new DateFormat("EEEE dd MMM HH'h'mm");
  int _selectedTab = 0;
  
  List<Slot> get _standardSlots => this.widget.slots
    .where((slot) => slot.slotType == SlotType.STANDARD)
    .toList();

  List<Slot> get _vipSlots => this.widget.slots
    .where((slot) => slot.slotType == SlotType.VIP)
    .toList();

  Slot _selectedSlot;
  void _setSelectedSlot(Slot slot) {
    this.widget.onSlotSelected(slot);
  }

  @override
  Widget build(BuildContext context) {
    if (!this.widget.isLoading && this._selectedSlot == null && this.widget.slots.isNotEmpty) {
      this._setSelectedSlot(this.widget.slots[0]);
    }
    return new BaseStepWidget(
      title: this.widget.title,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new CupertinoSegmentedControl<int>(
            borderColor: ColorPalette.orange,
            selectedColor: ColorPalette.orange,
            unselectedColor: Colors.white,
            groupValue: this._selectedTab,
            children: {
              0: new Text("Standard"),
              1: new Text("VIP")
            },
            onValueChanged: (index) => this.setState(() => this._selectedTab = index)
          ),
          new SizedBox(height: 24),
          this._slotInformationWidget(this._selectedTab == 0 ? SlotType.STANDARD : SlotType.VIP)
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
        this._nextButton(this.widget.canMoveForward)
      ],
    );
  }

  Widget get _loadingWidget => new Container(
    child: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(),
          new SizedBox(height: 8),
          new Text("Chargement des créneaux")
        ],
      ),
    ),
  );

  Widget get _slotListWidget => this.widget.isLoading ?
    this._loadingWidget :
    new Container(
      child: new CupertinoPicker(
        useMagnifier: true,
        backgroundColor: Colors.transparent,
        itemExtent: Theme.of(context).textTheme.display2.fontSize,
        onSelectedItemChanged: (index) {
          this._setSelectedSlot(this._selectedTab == 0 ? this._standardSlots[index] : this._vipSlots[index]);
        },
        children: (this._selectedTab == 0 ? this._standardSlots : this._vipSlots)
          .map((slot) => new Container(
            padding: new EdgeInsets.all(8),
            child: new Center(
              child: new Text(this._dateFormat.format(slot.startDate)),
            ),
          ))
          .toList()
      ),
    );

  Widget _nextButton(bool enabled) => new Row(
    children: <Widget>[
      new Expanded(
        child: new Container(
          height: 40,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(8),
              color: enabled ? ColorPalette.orange : ColorPalette.lightGray
          ),
          child: new ButtonTheme(
            height: double.infinity,
            child: new FlatButton(
              child: new Text("SUIVANT"),
              textColor: Colors.white,
              onPressed: enabled ? this.widget.onSlotConfirmed : null
            ),
          ),
        ),
      )
    ],
  );

}