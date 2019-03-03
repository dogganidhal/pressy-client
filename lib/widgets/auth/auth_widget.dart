import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/widgets/auth/login_widget.dart';
import 'package:pressy_client/widgets/auth/signup_widget.dart';

class AuthWidget extends StatefulWidget {

  final AuthBloc authBloc;
  final IMemberSession memberSession;
  final WidgetBuilder nextWidgetBuilder;

  AuthWidget({
    @required this.authBloc, this.nextWidgetBuilder,
    @required this.memberSession
  }) : assert(authBloc != null), assert(memberSession != null);

  @override
  State<StatefulWidget> createState() => new _AuthWidgetState();
  
}

class _AuthWidgetState extends State<AuthWidget> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new BlocProvider(
      bloc: this.widget.authBloc,
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: new Text("Authentification"),
          centerTitle: true,
          bottom: new TabBar(
            controller: this._tabController,
            tabs: <Widget>[
              new Container(
                padding: new EdgeInsets.only(bottom: 8, top: 8),
                child: new Text("INSCRIPTION")
              ),
              new Container(
                padding: new EdgeInsets.only(bottom: 8, top: 8),
                child: new Text("CONNEXION"),
              )
            ],
          ),
        ),/**/
        body: new TabBarView(
          controller: this._tabController,
          children: <Widget>[
            new SignUpWidget(
              authBloc: this.widget.authBloc,
              onAuthCompleted: () => Navigator.pop(this.context),
              memberSession: this.widget.memberSession,
            ),
            new LoginWidget(
              authBloc: this.widget.authBloc,
              onAuthCompleted: () => Navigator.pop(this.context),
              memberSession: this.widget.memberSession,
            )
          ],
        ),
      ),
    );
  }

}