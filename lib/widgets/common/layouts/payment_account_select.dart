import 'package:flutter/material.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class PaymentAccountSelect extends StatefulWidget {

  final ValueChanged<PaymentAccount> onPaymentAccountSelected;
  final List<PaymentAccount> paymentAccounts;

  PaymentAccountSelect({Key key, @required this.paymentAccounts, this.onPaymentAccountSelected}) 
    : super(key: key);

  @override
  State<StatefulWidget> createState() => new _PaymentAccountSelectState();

}

class _PaymentAccountSelectState extends State<PaymentAccountSelect> {

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
        shrinkWrap: true,
        itemCount: this.widget.paymentAccounts.length,
        separatorBuilder: (context, index) => new SizedBox(height: 12),
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => new _PaymentAccountRowWidget(
          paymentAccount: this.widget.paymentAccounts[index],
          onTapped: () => this.setState(() {
            this.widget.onPaymentAccountSelected(this.widget.paymentAccounts[index]);
            this.setState(() => this._selectedIndex = index);
          }),
          isSelected: this._selectedIndex == index,
        )
    );
  }

}

class _PaymentAccountRowWidget extends StatelessWidget {

  final PaymentAccount paymentAccount;
  final VoidCallback onTapped;
  final bool isSelected;

  _PaymentAccountRowWidget({Key key, this.onTapped, this.paymentAccount, this.isSelected = false}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: this.onTapped,
      child: new Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(4),
            border: new Border.all(color: this.isSelected ? ColorPalette.orange : ColorPalette.borderGray),
            color: this.isSelected ? ColorPalette.orange.withOpacity(0.33) : Colors.transparent
        ),
        child: new ListTile(
            title: new Text(this.paymentAccount.cardAlias),
            subtitle: new Text(
              "Expire le : ${this.paymentAccount.expiryYear}/${this.paymentAccount.expiryMonth}\n"
              "${this.paymentAccount.holderName}"
            ),
            trailing: this.isSelected ?
            new Icon(Icons.check_circle, color: ColorPalette.orange) :
            new Icon(Icons.radio_button_unchecked, color: ColorPalette.borderGray)
        ),
      ),
    );
  }

}