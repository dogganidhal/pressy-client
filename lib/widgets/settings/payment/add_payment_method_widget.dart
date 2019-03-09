import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_bloc.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_event.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_state.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/services/providers/location/user_location_provider.dart';
import 'package:pressy_client/utils/formatters/masked_input_formatter.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/utils/validators/validators.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';

class AddPaymentMethodWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _AddPaymentMethodWidgetState();

}


class _AddPaymentMethodWidgetState extends State<AddPaymentMethodWidget>
    with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {

  TextEditingController _cardNumberController = new TextEditingController();
  TextEditingController _expiryDateController = new TextEditingController();
  TextEditingController _cvcController = new TextEditingController();
  TextEditingController _cardHolderNameController = new TextEditingController();
  GlobalKey _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        title: new Text("Ajouter une CB"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: new SafeArea(
        child: new Container(
          padding: new EdgeInsets.all(12),
          child: new Form(
            child: this._creditCardForm
          ),
        )
      ),
    );
  }

  Widget get _creditCardForm => new Column(
    children: <Widget>[
      this._cardNumberField,
      this._expiryDateCvcRow,
      this._cardHolderNameField,
    ],
  );

  Widget get _expiryDateCvcRow => new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      new Flexible(
        child: new Container(
            padding: new EdgeInsets.only(right: 6),
            child: this._expiryDateField
        ),
      ),
      new Flexible(
          child: new Container(
              padding: new EdgeInsets.only(left: 6),
              child: this._cvcField
          )
      )
    ],
  );

  Widget get _expiryDateField => new TextFormField(
    controller: this._expiryDateController,
    decoration: new InputDecoration(
        labelText: "Date d'expiration",
        helperText: "Date d'expiration"
    ),
    keyboardType: TextInputType.number,
    inputFormatters: [
      new MaskedTextInputFormatter(mask: "xx/xx", separator: "/"),
      new LengthLimitingTextInputFormatter(5)
    ],
  );

  Widget get _cvcField => new TextFormField(
    controller: this._cvcController,
    decoration: new InputDecoration(
        labelText: "CVC",
        helperText: "CVC"
    ),
    keyboardType: TextInputType.number,
    inputFormatters: [
      new LengthLimitingTextInputFormatter(3)
    ],
  );

  Widget get _cardNumberField => new TextFormField(
    controller: this._cardNumberController,
    decoration: new InputDecoration(
      helperText: "Le numéro de votre carte à 16 chiffres",
      labelText: "Numéro de carte",
    ),
    inputFormatters: [
      new MaskedTextInputFormatter(mask: "xxxx xxxx xxxx xxxx", separator: " "),
      new LengthLimitingTextInputFormatter(19)
    ],
//    validator: Validators.emailValidator,
    keyboardType: TextInputType.number,
  );

  Widget get _cardHolderNameField => new TextFormField(
    controller: this._cardHolderNameController,
    decoration: new InputDecoration(
      helperText: "Le nom qui figure sur la carte",
      labelText: "Nom du proteur",
    ),
//    validator: Validators.phoneNumberValidator,
    keyboardType: TextInputType.text,
    textCapitalization: TextCapitalization.words,
  );
  
  void _handleState(state) {

  }

}