import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/blocs/auth/login/login_event.dart';
import 'package:pressy_client/blocs/auth/login/login_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/utils/validators/validators.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthBloc authBloc;
  final IMemberDataSource memberDataSource;
  final IAuthDataSource authDataSource;
  final IMemberSession userSession;

  LoginBloc({
    @required this.authBloc, @required this.memberDataSource, 
    @required this.userSession, @required this.authDataSource
  });
  
  @override
  LoginState get initialState => null;

  @override
  Stream<LoginState> mapEventToState(LoginState currentState, LoginEvent event) async* {
    
    if (event is LoginSubmitFormEvent) {

      bool isValid = Validators.emailValidator(event.email) == null;
      isValid &= event.password != null && event.password.isNotEmpty;
      yield new LoginInitialState(isValid: isValid);

    }

    if (event is LoginButtonPressedEvent) {

      yield new LoginLoadingState();

      try {

        var loginRequest = new LoginRequestModel(email: event.email, password: event.password);
        var authCredentials = await this.authDataSource.login(loginRequest);
        
        this.authBloc.dispatch(new AuthLoggedInEvent(
          authCredentials: authCredentials
        ));
        
        MemberProfile memberProfile = await this.memberDataSource.getMemberProfile();
        await this.userSession.persistMemberProfile(memberProfile);
        
        yield new LoginSuccessState();

      } on ApiError catch (error) {
        yield new LoginFailureState(error: error);
      } // TODO: May be handle other types of errors

    }

  }
  
}