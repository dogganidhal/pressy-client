import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_event.dart';
import 'package:pressy_client/blocs/auth/login/login_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session_impl.dart';

class LoginWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginWidgetState();
  
}

class _LoginWidgetState extends State<LoginWidget> {

  LoginBloc _loginBloc;

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
        return new Center(
          child: new Text("Login")
        );
      },
    );
  }

}