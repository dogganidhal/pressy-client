import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/model/order/order_builder/order_builder.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';


class OrderConfirmationWidget extends StatelessWidget {
  final OrderRequestBuilder orderRequest;
  final DateFormat _dateFormat = DateFormat("EEEE dd MMM HH'h'mm");
  final VoidCallback onOrderConfirmed;

  OrderConfirmationWidget({Key key, this.orderRequest, this.onOrderConfirmed}) :
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStepWidget(
      title: "CONFIRMATION",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            maxLines: 2,
            text: TextSpan(
              text: "• Créneau de collecte : ",
              style: DefaultTextStyle.of(context).style
                  .copyWith(color: ColorPalette.darkGray),
              children: <TextSpan>[
                TextSpan(
                  text: this._dateFormat.format(this.orderRequest.pickupSlot.startDate),
                  style: DefaultTextStyle.of(context).style
                    .copyWith(fontWeight: FontWeight.bold, color: ColorPalette.textBlack)
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          RichText(
            maxLines: 2,
            text: TextSpan(
              text: "• Créneau de livraison : ",
              style: DefaultTextStyle.of(context).style
                  .copyWith(color: ColorPalette.darkGray),
              children: <TextSpan>[
                TextSpan(
                  text: this._dateFormat.format(this.orderRequest.deliverySlot.startDate),
                  style: DefaultTextStyle.of(context).style
                    .copyWith(fontWeight: FontWeight.bold, color: ColorPalette.textBlack)
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          RichText(
            maxLines: 2,
            text: TextSpan(
              text: "• Type de commande : ",
              style: DefaultTextStyle.of(context).style
                  .copyWith(color: ColorPalette.darkGray),
              children: <TextSpan>[
                TextSpan(
                    text: this.orderRequest.orderType == OrderType.PRESSING ?
                      "PRESSING" :
                      "LINGE AU KILO",
                    style: DefaultTextStyle.of(context).style
                        .copyWith(fontWeight: FontWeight.bold, color: ColorPalette.textBlack)
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          RichText(
            maxLines: 2,
            text: TextSpan(
              text: "• Adresse de collecte & livraison : ",
              style: DefaultTextStyle.of(context).style
                .copyWith(color: ColorPalette.darkGray),
              children: <TextSpan>[
                TextSpan(
                  text: this.orderRequest.address.formattedAddress,
                  style: DefaultTextStyle.of(context).style
                    .copyWith(fontWeight: FontWeight.bold, color: ColorPalette.textBlack)
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          RichText(
            maxLines: 2,
            text: TextSpan(
              text: "• Moyen de paiement : ",
              style: DefaultTextStyle.of(context).style
                  .copyWith(color: ColorPalette.darkGray),
              children: <TextSpan>[
                TextSpan(
                  text: this._formatCardAlias(this.orderRequest.paymentAccount.cardAlias),
                  style: DefaultTextStyle.of(context).style
                    .copyWith(fontWeight: FontWeight.bold, color: ColorPalette.textBlack)
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          RichText(
            maxLines: 2,
            text: TextSpan(
              text: "• Montant estimé : ",
              style: DefaultTextStyle.of(context).style
                  .copyWith(color: ColorPalette.darkGray),
              children: <TextSpan>[
                TextSpan(
                    text: "${this.orderRequest.estimatedPrice} €",
                    style: DefaultTextStyle.of(context).style
                        .copyWith(fontWeight: FontWeight.bold, color: ColorPalette.textBlack)
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          this._nextButton
        ],
      ),
    );
  }

  Widget get _nextButton => Row(
    children: <Widget>[
      Expanded(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorPalette.orange
          ),
          child: ButtonTheme(
            height: double.infinity,
            child: FlatButton(
              child: Text("SUIVANT"),
              textColor: Colors.white,
              onPressed: this.onOrderConfirmed
            ),
          ),
        ),
      )
    ],
  );

  String _formatCardAlias(String cardAlias) {
    final regexp = RegExp(".{4}");
    final matches = regexp.allMatches(cardAlias)
        .map((match) => cardAlias.substring(match.start, match.end));
    return matches.join(" ");
  }

}