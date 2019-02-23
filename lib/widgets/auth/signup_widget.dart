import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_event.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/utils/validators/validators.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';

class SignUpWidget extends StatefulWidget {

  final AuthBloc authBloc;
  final IMemberSession memberSession;
  final VoidCallback onAuthCompleted;

  SignUpWidget({@required this.onAuthCompleted, @required this.memberSession, @required this.authBloc}) :
    assert(memberSession != null);

  @override
  State<StatefulWidget> createState() => new _SignUpWidgetState();
  
}

class _SignUpWidgetState extends State<SignUpWidget> with WidgetLifeCycleMixin, 
  LoaderMixin, ErrorMixin {

  SignUpBloc _signUpBloc;
  TextEditingController _firstNameFieldController = new TextEditingController();
  TextEditingController _lastNameFieldController = new TextEditingController();
  TextEditingController _emailFieldController = new TextEditingController();
  TextEditingController _phoneNumberFieldController = new TextEditingController();
  TextEditingController _passwordFieldController = new TextEditingController();
  TextEditingController _passwordConfirmationFieldController = new TextEditingController();

  bool _acceptsTerms = false;

  @override
  void initState() {
    super.initState();
    this._signUpBloc = new SignUpBloc(
      authBloc: this.widget.authBloc,
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
      memberSession: this.widget.memberSession
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new BlocBuilder<SignUpEvent, SignUpState>(
        bloc: this._signUpBloc, 
        builder: (context, state) {
          this.onWidgetDidBuild(() => this._handleState(state));
          return new Column(
            children: <Widget>[
              new Expanded(
                child: new SingleChildScrollView(
                  child: new Container(
                    padding: new EdgeInsets.all(16),
                    child: new Form(
                      child: this._signUpForm,
                      autovalidate: true,
                      onChanged: this._signUpFormChanged
                    )
                  ),
                ),
              ),
              this._signUpStickyButton(state is SignUpInitialState && state.isValid)
            ],
          );
        },
      ),
    );
  }

  void _signUpFormChanged() {
    this._signUpBloc.dispatch(new SignUpSubmitFormEvent(
      email: this._emailFieldController.text,
      password: this._passwordFieldController.text,
      firstName: this._firstNameFieldController.text,
      lastName: this._lastNameFieldController.text,
      phoneNumber: this._phoneNumberFieldController.text,
      passwordConfirmation: this._passwordConfirmationFieldController.text,
      acceptsTerms: this._acceptsTerms
    ));
  }

  void _handleState(SignUpState state) {
    if (state is SignUpLoadingState)
      this.showLoaderSnackBar(context);
    else
      this.hideLoaderSnackBar(context);

    if (state is SignUpFailureState)
      this.showErrorDialog(context, state.error);

    if (state is SignUpSuccessState)
      this._openNextWidget();
  }

  void _openNextWidget() {
    this.hideLoaderSnackBar(context);
    this.widget.onAuthCompleted();
  }

  Widget get _signUpForm => new Column(
    children: <Widget>[
      this._nameFieldRow,
      this._emailField,
      this._phoneField,
      this._passwordField,
      this._passwordConfirmationField,
      this._termsCheckbox
    ],
  );

  Widget get _nameFieldRow => new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      new Flexible(
        child: new Container(
          padding: new EdgeInsets.only(right: 6),
          child: this._lastNameField
        ),
      ),
      new Flexible(
        child: new Container(
          padding: new EdgeInsets.only(left: 6),
          child: this._firstNameField
        )
      )
    ],
  );

  Widget get _lastNameField => new TextFormField(
    controller: this._firstNameFieldController,
    decoration: new InputDecoration(
      labelText: "Nom",
      helperText: "Votre nom"
    ),
    keyboardType: TextInputType.text,
    validator: Validators.nameValidator,
    textCapitalization: TextCapitalization.words,
  );

  Widget get _firstNameField => new TextFormField(
    controller: this._lastNameFieldController,
    decoration: new InputDecoration(
      labelText: "Prénom",
      helperText: "Votre prénom"
    ),
    keyboardType: TextInputType.text,
    validator: Validators.nameValidator,
    textCapitalization: TextCapitalization.words,
  );

  Widget get _emailField => new TextFormField(
    controller: this._emailFieldController,
    decoration: new InputDecoration(
      helperText: "Votre email sera utilisé pour vous identifier",
      labelText: "Email",
    ),
    validator: Validators.emailValidator,
    keyboardType: TextInputType.emailAddress,
  );

  Widget get _phoneField => new TextFormField(
    controller: this._phoneNumberFieldController,
    decoration: new InputDecoration(
      helperText: "Votre téléphone sera utilisé pour vous contacter",
      labelText: "Numéro de téléphone",
    ),
    validator: Validators.phoneNumberValidator,
    keyboardType: TextInputType.phone,
  );

  Widget get _passwordField => new TextFormField(
    controller: this._passwordFieldController,
    decoration: new InputDecoration(
      helperText: "Votre mot de passe",
      labelText: "Mot de passe"
    ),
    obscureText: true,
    validator: Validators.newPasswordValidator
  );

  Widget get _passwordConfirmationField => new TextFormField(
    controller: this._passwordConfirmationFieldController,
    decoration: new InputDecoration(
      helperText: "Confirmer votre mot de passe",
      labelText: "Confirmation"
    ),
    obscureText: true,
    validator: (p) => 
      Validators.passwordConfirmationValidator(
        this._passwordFieldController.text, p
      )
  );

  Widget get _termsCheckbox => new Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      new Checkbox(
        value: this._acceptsTerms,
        onChanged: (value) {
          this.setState(() => this._acceptsTerms = value);
          this._signUpFormChanged();
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
        activeColor: ColorPalette.orange,
      ),
      new Text(
        "J'accepte les conditions générales d'utilisation",
        style: new TextStyle(color: ColorPalette.darkGray)
      )
    ],
  );

  Widget _signUpStickyButton(bool isFormValid) => new Row(
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
              child: new Text("S'INSCRIRE"),
              textColor: Colors.white,
              onPressed: isFormValid ? () => this._signUpBloc.dispatch(
                new SignUpButtonPressedEvent(
                  email: this._emailFieldController.text,
                  password: this._passwordFieldController.text,
                  firstName: this._firstNameFieldController.text,
                  lastName: this._lastNameFieldController.text,
                  phoneNumber: this._phoneNumberFieldController.text,
                  passwordConfirmation: this._passwordConfirmationFieldController.text
                )
              ) : null,
            ),
          ),
        ),
      )
    ],
  );

}