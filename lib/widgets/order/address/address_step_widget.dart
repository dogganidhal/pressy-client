import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/common/layouts/address_select.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';

class AddressStepWidget extends StatefulWidget {
  final VoidCallback onAddressConfirmed;
  final ValueChanged<MemberAddress> onAddressSelected;
  final List<MemberAddress> addresses;
  final bool isLoading;

  const AddressStepWidget(
      {Key key,
      this.onAddressSelected,
      this.addresses = const [],
      this.isLoading = true,
      this.onAddressConfirmed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddressStepWidgetState();
}

class _AddressStepWidgetState extends State<AddressStepWidget> {
  bool _didSelectAddress = false;

  @override
  Widget build(BuildContext context) {
    return BaseStepWidget(
        title: "Adresse", child: Column(children: this._buildRows().toList()));
  }

  Iterable<Widget> _buildRows() sync* {
    if (this.widget.isLoading)
      yield this._loadingWidget;
    else {
      yield Text(
        "Pour crée une nouvelle adresse veuillez sélectionner l'onglet paramètres > mes adresses. \n"
        "Ajoutez également un moyen de paiement ! : paramètres > moyen de paiement",
        style: TextStyle(color: ColorPalette.darkGray),
      );
      yield SizedBox(height: 12);
      yield AddressSelect(
        addresses: this.widget.addresses,
        onAddressSelected: (address) {
          this.widget.onAddressSelected(address);
          this.setState(() {
            this._didSelectAddress = true;
          });
        },
      );
    }

    yield SizedBox(height: 12);

    yield this._nextButton(!this.widget.isLoading && this._didSelectAddress);
  }

  Widget get _loadingWidget => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text("Chargement de vos adresses")
            ],
          ),
        ),
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
                    onPressed: enabled ? this.widget.onAddressConfirmed : null),
              ),
            ),
          )
        ],
      );
}
