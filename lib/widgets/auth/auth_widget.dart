import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/widgets/auth/login_widget.dart';
import 'package:pressy_client/widgets/auth/signup_widget.dart';

class AuthWidget extends StatefulWidget {

  final AuthBloc authBloc;

  AuthWidget({@required this.authBloc});

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
          bottom: new TabBar(
            controller: this._tabController,
            tabs: <Widget>[
              new Container(
                padding: new EdgeInsets.only(top: 8, bottom: 8),
                child: new Text("INSCRIPTION")
              ),
              new Container(
                padding: new EdgeInsets.only(top: 8, bottom: 8),
                child: new Text("CONNEXON"),
              )
            ],
          ),
        ),
        body: new TabBarView(
          controller: this._tabController,
          children: <Widget>[
            new LoginWidget(),
            new SignUpWidget()
          ],
        ),
      ),
    );
  }

}