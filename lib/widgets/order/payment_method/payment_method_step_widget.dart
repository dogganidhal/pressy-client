import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';


class PaymentMethodStepWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _PaymentMethodStepWidgetState();

}

class _PaymentMethodStepWidgetState extends State<PaymentMethodStepWidget> {

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: "Moyen de paiement",
      child: new Text("Veuillez sélectionner ou rajouter votre carte bancaire avec laquelle vous voulez ."),
    );
  }

}