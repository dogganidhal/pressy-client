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
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: new Text("Mon Profile"),
        centerTitle: true,
      ),
      body: new BlocBuilder<AuthEvent, AuthState>(
        bloc: this._authBloc,
        builder: (context, authState) {
          final widgets = List.unmodifiable(this._buildWidgets(authState));
          return new ListView.separated(
            itemCount: widgets.length,
            itemBuilder: (context, index) => widgets[index],
            padding: new EdgeInsets.only(top: 12, bottom: 12),
            separatorBuilder: (context, index) => new Container(height: 12),
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
    color: Colors.white,
    child: new ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (context, index) => index != 0 ? new Divider(height: 1) : new Container(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return new Container(
              padding: new EdgeInsets.all(12),
                child: new Text(
                  "Bonjour ${memberProfile.firstName}",
                  style: new TextStyle(
                    fontSize: 16
                  ),
                ),
              );
            case 1: 
              return new Container(
                padding: new EdgeInsets.only(bottom: 12, top: 12),
                child: new ButtonTheme(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: new FlatButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.person),
                        new SizedBox(width: 12),
                        new Expanded(
                          child: new Text("Mon profil"),
                        ),
                        new Icon(Icons.chevron_right)
                      ],
                    ),
                    onPressed: () => print("Mon profil"),
                  ),
                ),
              );
            case 2: 
              return new Container(
                padding: new EdgeInsets.only(bottom: 12, top: 12),
                child: new ButtonTheme(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: new FlatButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.credit_card),
                        new SizedBox(width: 12),
                        new Expanded(
                          child: new Text("Mes moyens de paiement"),
                        ),
                        new Icon(Icons.chevron_right)
                      ],
                    ),
                    onPressed: () => print("Mes moyens de paiement"),
                  ),
                ),
              );
            case 3: 
              return new Container(
                padding: new EdgeInsets.only(bottom: 12, top: 12),
                child: new ButtonTheme(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: new FlatButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.location_city),
                        new SizedBox(width: 12),
                        new Expanded(
                          child: new Text("Mes adresses"),
                        ),
                        new Icon(Icons.chevron_right)
                      ],
                    ),
                    onPressed: () => print("Mes adresses"),
                  ),
                ),
              );
          default:
        }
      },
    ),
  );

  Widget get _pressyServiceWidget => new Container(
    color: Colors.white,
    child: new ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (context, index) => new Divider(height: 1),
      itemBuilder: (context, index) {
        switch(index) {
          case 0:
            return new Container(
              padding: new EdgeInsets.only(bottom: 12, top: 12),
              child: new ButtonTheme(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: new FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.info),
                      new SizedBox(width: 12),
                      new Expanded(
                        child: new Text("Comment ça marche ?"),
                      ),
                      new Icon(Icons.chevron_right)
                    ],
                  ),
                  onPressed: () => print("Comment ça marche"),
                ),
              ),
            );
          case 1:
            return new Container(
              padding: new EdgeInsets.only(bottom: 12, top: 12),
              child: new ButtonTheme(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: new FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.mail),
                      new SizedBox(width: 12),
                      new Expanded(
                        child: new Text("Nous contacter"),
                      ),
                      new Icon(Icons.chevron_right)
                    ],
                  ),
                  onPressed: () => print("Nous contacter"),
                ),
              ),
            );
          case 2:
            return new Container(
              padding: new EdgeInsets.only(bottom: 12, top: 12),
              child: new ButtonTheme(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: new FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.lock),
                      new SizedBox(width: 12),
                      new Expanded(
                        child: new Text("Conditions générales d'utilisation"),
                      ),
                      new Icon(Icons.chevron_right)
                    ],
                  ),
                  onPressed: () => print("Conditions générales d'utilisation"),
                ),
              ),
            );
        }
      }
    )
  );

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