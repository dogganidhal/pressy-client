import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_event.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session_impl.dart';

class SignUpWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SignUpWidgetState();
  
}

class _SignUpWidgetState extends State<SignUpWidget> {

  SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    this._signUpBloc = new SignUpBloc(
      authBloc: BlocProvider.of<AuthBloc>(this.context), 
      memberDataSource: DataSourceFactory.createMemberDataSource(), 
      memberSession: new MemberSessionImpl()
    );
  }

  @override
  Widget build(BuildContext context) {
    return new BlocBuilder<SignUpEvent, SignUpState>(
      bloc: this._signUpBloc, 
      builder: (context, state) {
        return new Center(
          child: new Text("Sign up")
        );
      },
    );
  }

}