import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/blocs/auth/auth_state.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final IAuthSession authSession;

  AuthBloc({@required this.authSession});
  
  @override
  AuthState get initialState => new AuthUninitializedState();

  @override
  Stream<AuthState> mapEventToState(AuthState currentState, AuthEvent event) async* {
    
    if (event is AuthAppStartedEvent) {

      yield new AuthLoadingState();

      final hasToken = await this.authSession.hasCredentials();

      if (hasToken) {

        final authCredentials = await this.authSession.getPersistedAuthCredentials();
      
        yield new AuthAuthenticated(authCredentials: authCredentials,);

      } else
        yield new AuthUnauthenticatedState();

    }

    if (event is AuthLoggedInEvent) {

      yield new AuthLoadingState();
      await authSession.persistAuthCredentials(event.authCredentials);
      yield new AuthAuthenticated(authCredentials: event.authCredentials,);

    }

    if (event is AuthLoggedOutEvent) {

      yield new AuthLoadingState();
      await this.authSession.deleteAuthCredentials();
      yield new AuthUnauthenticatedState();

    }

  }
  
}