import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
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
  State<StatefulWidget> createState() => _AuthWidgetState();
  
}

class _AuthWidgetState extends State<AuthWidget> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    this._tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: this.widget.authBloc,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorPalette.orange),
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text("Authentification"),
          centerTitle: true,
          bottom: TabBar(
            controller: this._tabController,
            tabs: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 8, top: 8),
                child: Text("CONNEXION"),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8, top: 8),
                child: Text("INSCRIPTION")
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: this._tabController,
          children: <Widget>[
            LoginWidget(
              authBloc: this.widget.authBloc,
              onAuthCompleted: () => Navigator.pop(this.context),
              memberSession: this.widget.memberSession,
            ),
            SignUpWidget(
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