import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_event.dart';
import 'package:pressy_client/blocs/auth/login/login_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session_impl.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/utils/validators/validators.dart';

class LoginWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginWidgetState();
  
}

class _LoginWidgetState extends State<LoginWidget> {

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
      memberSession: new MemberSessionImpl(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new BlocBuilder<LoginEvent, LoginState>(
      bloc: this._loginBloc, 
      builder: (context, state) {
        return new Column(
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
            this._loginStickyButton
          ],
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
        validator: Validators.passwordValidator,
      ),
    ],
  );

  Widget get _loginStickyButton => new Row(
    children: <Widget>[
      new Expanded(
        child: new Container(
          height: 48,
          margin: new EdgeInsets.all(12),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(8),
            color: ColorPalette.orange
          ),
          child: new ButtonTheme(
            height: double.infinity,
            child: new FlatButton(
              child: new Text("CONNEXION"),
              textColor: Colors.white,
              onPressed: () => print("login"),
            ),
          ),
        ),
      )
    ],
  );

}