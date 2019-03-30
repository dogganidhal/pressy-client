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

  const AddressStepWidget({
    Key key, this.onAddressSelected, this.addresses = const [],
    this.isLoading = true, this.onAddressConfirmed
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _AddressStepWidgetState();

}

class _AddressStepWidgetState extends State<AddressStepWidget> {
  bool _didSelectAddress = false;

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: "Adresse",
      child: new Column(
        children: this._buildRows()
          .toList()
      )
    );
  }

  Iterable<Widget> _buildRows() sync* {

    if (this.widget.isLoading)
      yield this._loadingWidget;

    else {
      yield new Text(
        "Veuillez sélectionner ou créer l’adresse où vous voulez vous faire livré votre linge.",
        style: new TextStyle(color: ColorPalette.darkGray),
      );
      yield new SizedBox(height: 12);
      yield new AddressSelect(
        addresses: this.widget.addresses,
        onAddressSelected: (address) {
          this.widget.onAddressSelected(address);
          this.setState(() {
            this._didSelectAddress = true;
          });
        },
      );
    }

    yield new SizedBox(height: 12);

    yield this._nextButton(!this.widget.isLoading && this._didSelectAddress);

  }

  Widget get _loadingWidget => new Container(
    child: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(),
          new SizedBox(height: 8),
          new Text("Chargement de vos adresses")
        ],
      ),
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
                onPressed: enabled ? this.widget.onAddressConfirmed : null
            ),
          ),
        ),
      )
    ],
  );

}