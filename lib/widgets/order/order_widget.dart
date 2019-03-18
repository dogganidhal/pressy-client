import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/address/address_step_widget.dart';
import 'package:pressy_client/widgets/order/estimate_order/estimate_order_step_widget.dart';
import 'package:pressy_client/widgets/order/payment_method/payment_method_step_widget.dart';
import 'package:pressy_client/widgets/order/slot/slot_step_widget.dart';

class OrderWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _OrderWidgetState();

}

class _OrderWidgetState extends State<OrderWidget> {
  
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        backgroundColor: Colors.white,
        title: new Text("Passer une commande"),
        centerTitle: true,
      ),
      body: new Stepper(
        currentStep: this._currentStep,
        type: StepperType.horizontal,
        steps: [
          new Step(
            isActive: this._currentStep >= 0,
            state: this._stepState(0),
            title: new SizedBox(width: 0),
            content: new SlotWidget(title: "Créneau de collecte")
          ),
          new Step(
              isActive: this._currentStep >= 1,
            state: this._stepState(1),
            title: new SizedBox(width: 0),
              content: new SlotWidget(title: "Créneau de livraison")
          ),
          new Step(
            isActive: this._currentStep >= 2,
            state: this._stepState(2),
            title: new SizedBox(width: 0),
              content: new EstimateOrderStepWidget()
          ),
          new Step(
            isActive: this._currentStep >= 3,
            state: this._stepState(3),
            title: new SizedBox(width: 0),
            content: new AddressStepWidget()
          ),
          new Step(
            isActive: this._currentStep >= 4,
            state: this._stepState(4),
            title: new SizedBox(width: 0),
            content: new PaymentMethodStepWidget()
          ),
          new Step(
            isActive: this._currentStep >= 5,
            state: this._stepState(5),
            title: new SizedBox(width: 0),
            content: new Container(
              padding: new EdgeInsets.all(64),
              child: new Center(
                child: new Icon(Icons.adjust),
              ),
            )
          )
        ],
        onStepContinue: this._onStepContinue,
        onStepCancel: this._onStepCancel,
        controlsBuilder: (context, {onStepContinue, onStepCancel}) {
          return new Container();
        },
      ),
    );
  }

  void _onStepContinue() {
    if (this._currentStep == 5) return;
    this.setState(() => this._currentStep++);
  }
  
  void _onStepCancel() {
    if (this._currentStep == 0) return;
    this.setState(() => this._currentStep--);
  }
  
  StepState _stepState(int stepIndex) {
    if (this._currentStep > stepIndex)
      return StepState.complete;
    return StepState.indexed;
  }

}