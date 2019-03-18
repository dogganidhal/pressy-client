import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';


class AddressStepWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _AddressStepWidgetState();

}

class _AddressStepWidgetState extends State<AddressStepWidget> {

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: "Adresse",
      child: new Text("Veuillez sélectionner ou créer l’adresse où vous voulez vous faire livré votre linge.")
    );
  }

}