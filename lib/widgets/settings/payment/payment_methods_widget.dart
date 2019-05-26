import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pressy_client/data/model/payment/payment_acount/payment_account.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/settings/payment/add_payment_method_widget.dart';


class PaymentMethodsWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _PaymentMethodsWidgetState();

}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {

  GlobalKey _scaffoldKey = GlobalKey();
  List<PaymentAccount> get _paymentAccounts => ServiceProvider
    .of(this.context)
    .getService<IMemberSession>()
    .connectedMemberProfile
    .paymentAccounts;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[100],
    appBar: AppBar(
      iconTheme: IconThemeData(color: ColorPalette.orange),
      title: Text("Mes CB"),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1,
      actions: <Widget>[
        FlatButton.icon(
          onPressed: this._launchAddAddressWidget,
          icon: Icon(Icons.add, color: ColorPalette.orange),
          label: Container()
        )
      ],
    ),
    body: Column(
      key: this._scaffoldKey,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 24, bottom: 12, left: 12, right: 12),
          child: Text(
            "Pour modifier ou supprimer une de vos moyens de paiement, glisser vers la gauche",
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            itemBuilder: (context, index) => this._paymentAccountRow(this._paymentAccounts[index]),
            separatorBuilder: (context, index) => Divider(height: 1),
            itemCount: this._paymentAccounts.length,
          )
        )
      ],
    ),
  );

  Widget _paymentAccountRow(PaymentAccount paymentAccount) => Slidable(
    delegate: SlidableDrawerDelegate(),
    child: Container(
      color: Colors.white,
      child: ListTile(
        title: Text(this._formatCardAlias(paymentAccount.cardAlias)),
        subtitle: Text(
          "Expire le : ${paymentAccount.expiryMonth}/${paymentAccount.expiryYear}\n"
          "${paymentAccount.holderName}"
        ),
        isThreeLine: true,
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Supprimer',
        color: ColorPalette.red,
        icon: Icons.delete,
        onTap: () => print('Supprimer'),
      ),
      IconSlideAction(
        foregroundColor: Colors.white,
        caption: 'Modifier',
        color: ColorPalette.orange,
        icon: Icons.edit,
        onTap: () => print('Modifier'),
      ),
    ],
  );

  void _launchAddAddressWidget() {
    final services  = ServiceProvider.of(this.context);
    Navigator.of(this.context)
      .push(MaterialPageRoute(
        builder: (context) => ServiceProvider(
          child: AddPaymentMethodWidget(),
          services: services
        )
      )
    );
  }

  String _formatCardAlias(String cardAlias) {
    final regexp = RegExp(".{4}");
    final matches = regexp.allMatches(cardAlias)
      .map((match) => cardAlias.substring(match.start, match.end));
    return matches.join(" ");
  }

}