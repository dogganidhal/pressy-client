import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_event.dart';
import 'package:pressy_client/blocs/auth/login/login_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/utils/validators/validators.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';

class LoginWidget extends StatefulWidget {

  final AuthBloc authBloc;
  final IMemberSession memberSession;
  final VoidCallback onAuthCompleted;

  LoginWidget({@required this.memberSession, @required this.onAuthCompleted, @required this.authBloc}) :
    assert(memberSession != null);

  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
  
}

class _LoginWidgetState extends State<LoginWidget> with WidgetLifeCycleMixin, 
  LoaderMixin, ErrorMixin {

  LoginBloc _loginBloc;
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this._loginBloc = LoginBloc(
      authBloc: this.widget.authBloc,
      authDataSource: ServiceProvider.of(this.context).getService<IAuthDataSource>(),
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: this._loginBloc, 
      builder: (context, state) {
        this.onWidgetDidBuild(() => this._handleState(state));
        return SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      child: this._loginForm,
                      autovalidate: true,
                      onChanged: () => this._loginBloc.dispatch(LoginSubmitFormEvent(
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

  Widget get _loginForm => Column(
    children: <Widget>[
      TextFormField(
        controller: this._emailFieldController,
        decoration: InputDecoration(
          helperText: "Votre email sera utilisé pour vous identifier",
          labelText: "Email",
        ),
        validator: Validators.emailValidator,
        keyboardType: TextInputType.emailAddress,
      ),
      TextFormField(
        controller: this._passwordFieldController,
        decoration: InputDecoration(
          helperText: "Votre mot de passe",
          labelText: "Mot de passe"
        ),
        obscureText: true,
        validator: Validators.loginPasswordValidator,
      ),
    ],
  );

  Widget _loginStickyButton(bool isFormValid) => Row(
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
              child: Text("CONNEXION"),
              textColor: Colors.white,
              onPressed: isFormValid ? () => this._loginBloc.dispatch(
                LoginButtonPressedEvent(
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
      this.showLoaderSnackBar(context);
    else
      this.hideLoaderSnackBar(context);

    if (state is LoginFailureState)
      this.showErrorDialog(context, state.error);

    if (state is LoginSuccessState)
      this._openNextWidget();
  }

  void _openNextWidget() {
    this.hideLoaderSnackBar(context);
    this.widget.onAuthCompleted();
  }

}