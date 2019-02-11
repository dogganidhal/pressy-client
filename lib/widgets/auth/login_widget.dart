import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_event.dart';
import 'package:pressy_client/blocs/auth/login/login_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/utils/validators/validators.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';

class LoginWidget extends StatefulWidget {

  final IMemberSession memberSession;
  final WidgetBuilder nextWidgetBuilder;

  LoginWidget({@required this.memberSession, @required this.nextWidgetBuilder}) :
    assert(memberSession != null);

  @override
  State<StatefulWidget> createState() => new _LoginWidgetState();
  
}

class _LoginWidgetState extends State<LoginWidget> with WidgetLifeCycleMixin, 
  LoaderMixin, ErrorMixin {

  LoginBloc _loginBloc;
  TextEditingController _emailFieldController = new TextEditingController();
  TextEditingController _passwordFieldController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this._loginBloc = new LoginBloc(
      authBloc: BlocProvider.of<AuthBloc>(this.context), 
      authDataSource: DataSourceFactory.createAuthDataSource(), 
      memberDataSource: DataSourceFactory.createMemberDataSource(), 
      memberSession: this.widget.memberSession
    );
  }

  @override
  Widget build(BuildContext context) {
    return new BlocBuilder<LoginEvent, LoginState>(
      bloc: this._loginBloc, 
      builder: (context, state) {
        this.onWidgetDidBuild(() => this._handleState(state));
        return new SafeArea(
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new SingleChildScrollView(
                  child: new Container(
                    padding: new EdgeInsets.all(16),
                    child: new Form(
                      child: this._loginForm,
                      autovalidate: true,
                      onChanged: () => this._loginBloc.dispatch(new LoginSubmitFormEvent(
                        email: this._emailFieldController.text,
                        password: this._passwordFieldController.text
                      )),
                    )
                  ),
                ),
              ),
              this._loginStickyButton(state is LoginInitialState && state.isValid)
            ],
          ),
        );
      },
    );
  }

  Widget get _loginForm => new Column(
    children: <Widget>[
      new TextFormField(
        controller: this._emailFieldController,
        decoration: new InputDecoration(
          helperText: "Votre email sera utilisé pour vous identifier",
          labelText: "Email",
        ),
        validator: Validators.emailValidator,
        keyboardType: TextInputType.emailAddress,
      ),
      new TextFormField(
        controller: this._passwordFieldController,
        decoration: new InputDecoration(
          helperText: "Votre mot de passe",
          labelText: "Mot de passe"
        ),
        obscureText: true,
        validator: Validators.loginPasswordValidator,
      ),
    ],
  );

  Widget _loginStickyButton(bool isFormValid) => new Row(
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
              child: new Text("CONNEXION"),
              textColor: Colors.white,
              onPressed: isFormValid ? () => this._loginBloc.dispatch(
                new LoginButtonPressedEvent(
                  email: this._emailFieldController.text,
                  password: this._passwordFieldController.text
                )
              ) : null,
            ),
          ),
        ),
      )
    ],
  );

  void _handleState(LoginState state) {
    if (state is LoginLoadingState)
      this.showLoader(context);
    else
      this.hideLoader(context);

    if (state is LoginFailureState)
      this.showErrorDialog(context, state.error);

    if (state is LoginSuccessState)
      this._openNextWidget();
  }

  void _openNextWidget() {
    this.hideLoader(this.context);
    Navigator.pushReplacement(this.context, new MaterialPageRoute(
      builder: this.widget.nextWidgetBuilder,
    ));
  }

}