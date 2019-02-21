import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/blocs/auth/auth_state.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/auth/auth_widget.dart';


class ProfileWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ProfileWidgetState();

}


class _ProfileWidgetState extends State<ProfileWidget> {

  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    this._authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: new Text("Mon Profile"),
        centerTitle: true,
      ),
      body: new BlocBuilder<AuthEvent, AuthState>(
        bloc: this._authBloc,
        builder: (context, authState) {
          return new Column(
            children: List.unmodifiable(this._buildWidgets(authState)),
          );
        }
      ),
    );
  }

  Iterable<Widget> _buildWidgets(AuthState state) sync* {

    if (state is AuthAuthenticated) {
      yield this._profilePreviewWidget(state.memberProfile);
    }

    yield this._pressyServiceWidget;

    if (state is AuthAuthenticated)
      yield this._logoutButton;
    else
      yield this._loginButton;

  }

  Widget _profilePreviewWidget(MemberProfile memberProfile) => new Container(
    child: new Column(
      children: <Widget>[
       new Text("Bonjour ${memberProfile.firstName}")
      ],
    ),
  );

  Widget get _pressyServiceWidget => new Container();

  Widget get _loginButton => new Container(
    height: 48,
    margin: EdgeInsets.only(left: 4),
    child: new FlatButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8)
      ),
      onPressed: () => this._launchAuthWidget(),
      textColor: ColorPalette.lightGray,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "LOGIN",
            style: new TextStyle(
              color: ColorPalette.orange,
              fontWeight: FontWeight.w600
            )
          ),
        ],
      )
    )
  );

  Widget get _logoutButton => new Container(
    height: 48,
    margin: EdgeInsets.only(left: 4),
    child: new FlatButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(8)
      ),
      onPressed: () => this._authBloc.dispatch(new AuthLoggedOutEvent()),
      textColor: ColorPalette.lightGray,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "LOGOUT",
            style: new TextStyle(
              color: ColorPalette.orange,
              fontWeight: FontWeight.w600
            )
          ),
        ],
      )
    )
  );

  void _launchAuthWidget() {
    final memberSession = ServiceProvider.of(this.context).getService<IMemberSession>();
    Navigator.push(this.context, new MaterialPageRoute(
      builder: (_) => new ServiceProvider(
        services: ServiceProvider.of(this.context),
        child: new AuthWidget(
          authBloc: this._authBloc,
          memberSession: memberSession
        )
      )
    ));
  }

}