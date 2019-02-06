import 'package:bloc/bloc.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_event.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  
  @override
  SignUpState get initialState => null;

  @override
  Stream<SignUpState> mapEventToState(SignUpState currentState, SignUpEvent event) async* {
    // TODO: implement mapEventToState
  }
  
}