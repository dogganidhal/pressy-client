import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/coupon/coupon_bloc.dart';
import 'package:pressy_client/blocs/order/order_bloc.dart';
import 'package:pressy_client/blocs/order/order_event.dart';
import 'package:pressy_client/data/data_source/coupon/coupon_data_source.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pressy_client/widgets/orders/promo_widget.dart';
import 'package:time_slot_picker/time_slot_picker.dart';

import 'dual_slot_widget.dart';

typedef void SlotSelectedCallback(Slot slot);
typedef void OnCouponAppliedCallback(
    String category, double couponValue, Coupon coupon);

class SlotWidget extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<Slot> slots;
  final SlotSelectedCallback onSlotSelected;
  final OnCouponAppliedCallback onCouponAppliedCallback;
  final VoidCallback onSlotConfirmed;
  final bool canMoveForward;
  final bool displaySlotTypeInfo;
  final SlotType slotType;
  final double promoAmount;
  SlotWidget(
      {Key key,
      @required this.title,
      @required this.onSlotSelected,
      this.onCouponAppliedCallback,
      @required this.onSlotConfirmed,
      this.canMoveForward = false,
      this.slots = const [],
      this.isLoading = true,
      this.displaySlotTypeInfo = true,
      this.slotType,
      this.promoAmount})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SlotWidgetState();
}

class _SlotWidgetState extends State<SlotWidget> {
  DateFormat _dateFormat = DateFormat("EEEE dd MMM HH'h'mm", "fr");
  int _selectedTab = 0;
  double _promoAmount = 0;
  List<Slot> get _standardSlots {
    var slots = this
        .widget
        .slots
        .where((slot) => slot.slotType == SlotType.STANDARD)
        .toList();
    slots.sort((lhs, rhs) => lhs.startDate.compareTo(rhs.startDate));
    return slots;
  }

  List<Slot> get _expressSlots {
    var slots = this
        .widget
        .slots
        .where((slot) => slot.slotType == SlotType.EXPRESS)
        .toList();
    slots.sort((lhs, rhs) => lhs.startDate.compareTo(rhs.startDate));
    return slots;
  }

  Slot _selectedSlot;
  void _setSelectedSlot(Slot slot) {
    this.widget.onSlotSelected(slot);
  }

  @override
  void initState() {
    super.initState();
    if (this.widget.slotType != null) {
      this._selectedTab = this.widget.slotType == SlotType.STANDARD ? 0 : 1;
    }
    if (this.widget.promoAmount != null) {
      this._promoAmount = this._promoAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!this.widget.isLoading &&
        this._selectedSlot == null &&
        this.widget.slots.isNotEmpty) {
      this._setSelectedSlot(this.widget.slots[0]);
    }
    return BaseStepWidget(
      title: this.widget.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: this._buildWidgets().toList(),
      ),
    );
  }

  Iterable<Widget> _buildWidgets() sync* {
    if (this.widget.displaySlotTypeInfo) {
      yield CupertinoSegmentedControl<int>(
          borderColor: ColorPalette.orange,
          selectedColor: ColorPalette.orange,
          unselectedColor: Colors.white,
          groupValue: this._selectedTab,
          children: {0: Text("Standard"), 1: Text("Express")},
          onValueChanged: (index) {
            this.setState(() => this._selectedTab = index);
          });
      yield SizedBox(height: 24);
    }
    yield this._slotInformationWidget(
        this._selectedTab == 0 ? SlotType.STANDARD : SlotType.EXPRESS);
  }

  Iterable<Widget> _buildSlotInfoWidgets(SlotType slotType) sync* {
    var orderState = BlocProvider.of<OrderBloc>(this.context).currentState;

    if (this.widget.displaySlotTypeInfo) {
      yield Row(
        children: <Widget>[
          Text("• Créneau de : ",
              style: TextStyle(color: ColorPalette.textGray)),
          Text("30 minutes", style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      );
      yield SizedBox(height: 8);
      yield Row(
        children: <Widget>[
          Text("• Frais de service : ",
              style: TextStyle(color: ColorPalette.textGray)),
          Text(slotType == SlotType.STANDARD ? "GRATUIT" : "8.99€",
              style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      );
      yield SizedBox(height: 8);
      yield Row(
        children: <Widget>[
          Text("• Délai de livraison : ",
              style: TextStyle(color: ColorPalette.textGray)),
          Text(slotType == SlotType.STANDARD ? "48h" : "24h",
              style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      );
      yield SizedBox(height: 8);
      yield SizedBox(
        height: 48,
        child: CupertinoTextField(
          prefix: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.edit,
              color: ColorPalette.textGray,
            ),
          ),
          placeholder: " Avez-vous une requête particulier?",
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorPalette.borderGray,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );
      yield SizedBox(height: 7);
      yield orderState.isCouponValid
          ? Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "You benefit from ${orderState.category == "amount" ? orderState.coupon.amountOff : orderState.coupon.percentOff} € on your order",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: ColorPalette.orange),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          this._promoAmount = 0;
                        });
                        this.widget.onCouponAppliedCallback("", 0, null);
                      },
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Remove",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            )
          : ListTile(
              leading: Icon(
                FontAwesomeIcons.gift,
                color: ColorPalette.orange,
              ),
              title: Text(
                "Entrez votre code promotionnel ou code de parrainage",
                style: TextStyle(color: ColorPalette.orange, fontSize: 13.0),
              ),
              onTap: () {
                //TODO:Design new Screen for promo-code
                final services = ServiceProvider.of(this.context);
                Future<Coupon> future = Navigator.push(
                    this.context,
                    MaterialPageRoute(
                        builder: (_) => ServiceProvider(
                            child: PromoScreen(), services: services)));

                future.then((Coupon coupon) {
                  if (coupon != null) {
                    if (coupon.amountOff == null) {
                      setState(() {
                        this._promoAmount = coupon.percentOff;
                      });
                      this.widget.onCouponAppliedCallback(
                          "percent", this._promoAmount, coupon);
                    } else {
                      setState(() {
                        this._promoAmount = coupon.amountOff.toDouble();
                      });
                      this.widget.onCouponAppliedCallback(
                          "amount", this._promoAmount, coupon);
                    }
                  }
                });
              },
            );
    }
    yield SizedBox(
      height: 124,
      child: this._slotListWidget,
    );
    yield SizedBox(height: 48);
    yield this._nextButton(this.widget.canMoveForward);
  }

  Widget _slotInformationWidget(SlotType slotType) {
    return Column(children: this._buildSlotInfoWidgets(slotType).toList());
  }

  Widget get _loadingWidget => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text("Chargement des créneaux")
            ],
          ),
        ),
      );

  Widget get _slotListWidget => this.widget.isLoading
      ? this._loadingWidget
      : Container(
          child: CupertinoPicker(
              useMagnifier: true,
              backgroundColor: Colors.transparent,
              itemExtent: Theme.of(context).textTheme.display2.fontSize,
              onSelectedItemChanged: (index) {
                this._setSelectedSlot(this._selectedTab == 0
                    ? this._standardSlots[index]
                    : this._expressSlots[index]);
              },
              children: (this._selectedTab == 0
                      ? this._standardSlots
                      : this._expressSlots)
                  .map((slot) => Container(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(this._dateFormat.format(slot.startDate)),
                        ),
                      ))
                  .toList()),
        );

  Widget _nextButton(bool enabled) => Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      enabled ? ColorPalette.orange : ColorPalette.lightGray),
              child: ButtonTheme(
                height: double.infinity,
                child: FlatButton(
                    child: Text("SUIVANT"),
                    textColor: Colors.white,
                    onPressed: enabled ? this.widget.onSlotConfirmed : null),
              ),
            ),
          )
        ],
      );
}
