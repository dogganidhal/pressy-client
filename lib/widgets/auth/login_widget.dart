import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_event.dart';
import 'package:pressy_client/blocs/auth/login/login_state.dart';

class LoginWidget extends StatefulWidget {

  final LoginBloc loginBloc;

  LoginWidget({@required this.loginBloc});

  @override
  State<StatefulWidget> createState() => new _LoginWidgetState();
  
}

class _LoginWidgetState extends State<LoginWidget> {

  @override
  Widget build(BuildContext context) {
    return new BlocBuilder<LoginEvent, LoginState>(
      bloc: this.widget.loginBloc, 
      builder: (context, state) {
        
      },
    );
  }

}