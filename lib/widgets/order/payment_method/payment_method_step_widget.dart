import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/common/layouts/payment_account_select.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';


class PaymentAccountStepWidget extends StatefulWidget {
  final VoidCallback onPaymentAccountConfirmed;
  final ValueChanged<PaymentAccount> onPaymentAccountSelected;
  final List<PaymentAccount> paymentAccounts;
  final bool isLoading;

  const PaymentAccountStepWidget({
    Key key, this.onPaymentAccountConfirmed, this.onPaymentAccountSelected, 
    this.paymentAccounts, this.isLoading
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _PaymentAccountStepWidgetState();

}

class _PaymentAccountStepWidgetState extends State<PaymentAccountStepWidget> {
  bool _didSelectPaymentMethod = false;

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: "MOYEN DE PAIEMENT",
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
        "Veuillez sélectionner votre carte bancaire avec laquelle vous voulez passer votre commande.",
        style: new TextStyle(color: ColorPalette.darkGray),
      );
      yield new SizedBox(height: 12);
      yield new PaymentAccountSelect(
        paymentAccounts: this.widget.paymentAccounts,
        onPaymentAccountSelected: (account) {
          this.widget.onPaymentAccountSelected(account);
          this.setState(() {
            this._didSelectPaymentMethod = true;
          });
        },
      );
    }

    yield new SizedBox(height: 12);

    yield this._nextButton(!this.widget.isLoading && this._didSelectPaymentMethod);

  }

  Widget get _loadingWidget => new Container(
    child: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(),
          new SizedBox(height: 8),
          new Text("Chargement de vos moyens de paiement")
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
                onPressed: enabled ? this.widget.onPaymentAccountConfirmed : null
            ),
          ),
        ),
      )
    ],
  );

}