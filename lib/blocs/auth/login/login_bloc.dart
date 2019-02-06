import 'package:bloc/bloc.dart';
import 'package:pressy_client/blocs/auth/login/login_event.dart';
import 'package:pressy_client/blocs/auth/login/login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  @override
  LoginState get initialState => null;

  @override
  Stream<LoginState> mapEventToState(LoginState currentState, LoginEvent event) async* {
    // TODO: implement mapEventToState
  }
  
}