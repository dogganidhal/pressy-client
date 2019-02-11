import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/blocs/auth/auth_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final IAuthSession authSession;
  final IAuthDataSource authDataSource;

  AuthBloc({@required this.authSession, @required this.authDataSource});
  
  @override
  AuthState get initialState => new AuthUninitializedState();

  @override
  Stream<AuthState> mapEventToState(AuthState currentState, AuthEvent event) async* {
    
    if (event is AuthAppStartedEvent) {

      yield new AuthLoadingState();

      await Future.delayed(new Duration(seconds: 5));

      final hasToken = await this.authSession.hasCredentials();

      if (hasToken) {

        final authCredentials = await this.authSession.getPersistedAuthCredentials();
        yield new AuthAuthenticated(authCredentials: authCredentials);
        this._renewAuthCredentials(authCredentials.refreshToken);

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

  void _renewAuthCredentials(String refreshToken) async {
    var authCredentials = await this.authDataSource.refreshCredentials(refreshToken);
    this.authSession.persistAuthCredentials(authCredentials);
  }
  
}