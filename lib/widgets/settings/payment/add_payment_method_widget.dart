import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/payment/payment_data_source.dart';
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
  State<StatefulWidget> createState() => _AddPaymentMethodWidgetState();

}


class _AddPaymentMethodWidgetState extends State<AddPaymentMethodWidget>
    with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {

  AddPaymentAccountBloc _bloc;
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvcController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    this._bloc = AddPaymentAccountBloc(
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
      memberSession: ServiceProvider.of(this.context).getService<IMemberSession>(),
      paymentDataSource: ServiceProvider.of(this.context).getService<IPaymentDataSource>()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        title: Text("Ajouter une CB"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        key: this._scaffoldKey,
        child: BlocBuilder<AddPaymentAccountEvent, AddPaymentAccountState>(
          bloc: this._bloc,
          builder: (context, state) {
            this._handleState(state);      
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Form(
                      child: this._creditCardForm,
                      autovalidate: true,
                      onChanged: () => this._bloc.dispatch(SubmitCreditCardEvent(
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

  Widget get _creditCardForm => Column(
    children: <Widget>[
      this._cardNumberField,
      this._expiryDateCvcRow,
      this._cardHolderNameField,
    ],
  );

  Widget get _expiryDateCvcRow => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Flexible(
        child: Container(
            padding: EdgeInsets.only(right: 6),
            child: this._expiryDateField
        ),
      ),
      Flexible(
          child: Container(
              padding: EdgeInsets.only(left: 6),
              child: this._cvcField
          )
      )
    ],
  );

  Widget get _expiryDateField => TextFormField(
    controller: this._expiryDateController,
    decoration: InputDecoration(
        labelText: "Date d'expiration",
    ),
    keyboardType: TextInputType.number,
    inputFormatters: [
      MaskedTextInputFormatter(mask: "xx/xx", separator: "/"),
      LengthLimitingTextInputFormatter(5),
      ExpiryDateInputFormatter()
    ],
    validator: Validators.expiryDateValidator,
  );

  Widget get _cvcField => TextFormField(
    controller: this._cvcController,
    decoration: InputDecoration(
      labelText: "CVC",
    ),
    keyboardType: TextInputType.number,
    inputFormatters: [
      LengthLimitingTextInputFormatter(3)
    ],
    validator: Validators.cvcValidator,
  );

  Widget get _cardNumberField => TextFormField(
    controller: this._cardNumberController,
    decoration: InputDecoration(
      helperText: "Le numéro de votre carte à 16 chiffres",
      labelText: "Numéro de carte",
    ),
    inputFormatters: [
      MaskedTextInputFormatter(mask: "xxxx xxxx xxxx xxxx", separator: " "),
      LengthLimitingTextInputFormatter(19)
    ],
    validator: Validators.creditCardValidator,
    keyboardType: TextInputType.number,
  );

  Widget get _cardHolderNameField => TextFormField(
    controller: this._cardHolderNameController,
    decoration: InputDecoration(
      helperText: "Le nom qui figure sur la carte",
      labelText: "Prénom et nom du porteur",
    ),
    validator: Validators.nameValidator,
    keyboardType: TextInputType.text,
    textCapitalization: TextCapitalization.words,
  );

  Widget _confirmStickyButton(bool isFormValid) => Row(
    children: <Widget>[
      Expanded(
        child: Container(
          height: 48,
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isFormValid ? ColorPalette.orange : ColorPalette.borderGray
          ),
          child: ButtonTheme(
            height: double.infinity,
            child: FlatButton(
              child: Text("CONFIRMER"),
              textColor: Colors.white,
              onPressed: isFormValid ? () => this._bloc.dispatch(ConfirmCreditCardEvent(
                creditCardNumber: this._cardNumberController.text,
                creditCardHolderName: this._cardHolderNameController.text,
                expiryDateString: this._expiryDateController.text,
                cvc: this._cvcController.text
              )) : null,
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
      this.onWidgetDidBuild(() => this.showErrorDialog(this._scaffoldKey.currentContext, state.error));
    }
    if (state is AddPaymentAccountSuccessState) {
      this.onWidgetDidBuild(() => Navigator.pop(this.context));
    }
  }

}