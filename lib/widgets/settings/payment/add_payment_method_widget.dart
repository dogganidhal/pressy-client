import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/formatters/expiry_date_formatter.dart';
import 'package:pressy_client/utils/formatters/masked_input_formatter.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/utils/validators/validators.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';
import 'package:pressy_client/blocs/settings/add_payment_acount/add_payment_account_bloc.dart';
import 'package:pressy_client/blocs/settings/add_payment_acount/add_payment_account_event.dart';
import 'package:pressy_client/blocs/settings/add_payment_acount/add_payment_account_state.dart';


class AddPaymentMethodWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _AddPaymentMethodWidgetState();

}


class _AddPaymentMethodWidgetState extends State<AddPaymentMethodWidget>
    with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {

  AddPaymentAccountBloc _bloc;
  TextEditingController _cardNumberController = new TextEditingController();
  TextEditingController _expiryDateController = new TextEditingController();
  TextEditingController _cvcController = new TextEditingController();
  TextEditingController _cardHolderNameController = new TextEditingController();
  GlobalKey _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    this._bloc = new AddPaymentAccountBloc(
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
      memberSession: ServiceProvider.of(this.context).getService<IMemberSession>(),
    );
  }

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
        key: this._scaffoldKey,
        child: new BlocBuilder<AddPaymentAccountEvent, AddPaymentAccountState>(
          bloc: this._bloc,
          builder: (context, state) {
            this._handleState(state);      
            return new Column(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    padding: new EdgeInsets.all(12),
                    child: new Form(
                      child: this._creditCardForm,
                      autovalidate: true,
                      onChanged: () => this._bloc.dispatch(new SubmitCreditCardEvent(
                        expiryDateString: this._expiryDateController.text, 
                        creditCardHolderName: this._cardHolderNameController.text, 
                        creditCardNumber: this._cardNumberController.text, 
                        cvc: this._cvcController.text
                      )),
                    ),
                  )
                ),
                this._confirmStickyButton(state is AddPaymentAccountInputState && state.isInputValid)
              ],
            );
          },
        ),
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
    ),
    keyboardType: TextInputType.number,
    inputFormatters: [
      new MaskedTextInputFormatter(mask: "xx/xx", separator: "/"),
      new LengthLimitingTextInputFormatter(5),
      new ExpiryDateInputFormatter()
    ],
    validator: Validators.expiryDateValidator,
  );

  Widget get _cvcField => new TextFormField(
    controller: this._cvcController,
    decoration: new InputDecoration(
      labelText: "CVC",
    ),
    keyboardType: TextInputType.number,
    inputFormatters: [
      new LengthLimitingTextInputFormatter(3)
    ],
    validator: Validators.cvcValidator,
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
    validator: Validators.creditCardValidator,
    keyboardType: TextInputType.number,
  );

  Widget get _cardHolderNameField => new TextFormField(
    controller: this._cardHolderNameController,
    decoration: new InputDecoration(
      helperText: "Le nom qui figure sur la carte",
      labelText: "Nom du proteur",
    ),
    validator: Validators.nameValidator,
    keyboardType: TextInputType.text,
    textCapitalization: TextCapitalization.words,
  );

  Widget _confirmStickyButton(bool isFormValid) => new Row(
    children: <Widget>[
      new Expanded(
        child: new Container(
          height: 48,
          margin: new EdgeInsets.all(12),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(8),
            color: isFormValid ? ColorPalette.orange : ColorPalette.borderGray
          ),
          child: new ButtonTheme(
            height: double.infinity,
            child: new FlatButton(
              child: new Text("CONFIRMER"),
              textColor: Colors.white,
              onPressed: isFormValid ? () => print(this._cardNumberController.text.split(' ').join()) : null,
            ),
          ),
        ),
      )
    ],
  );

  void _handleState(AddPaymentAccountState state) {
    if (state is AddPaymentAccountLoadingState) {
      this.onWidgetDidBuild(() => this.showLoaderSnackBar(this._scaffoldKey.currentContext));
    } else {
      this.onWidgetDidBuild(() => this.hideErrorDialog(this._scaffoldKey.currentContext));
    }
    if (state is AddPaymentAccountErrorState) {
      this.onWidgetDidBuild(() => this.showErrorDialog(this.context, state.error));
    }
    if (state is AddPaymentAccountSuccessState) {
      this.onWidgetDidBuild(() => Navigator.pop(this.context));
    }
  }

}