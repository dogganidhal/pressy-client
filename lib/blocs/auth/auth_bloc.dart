import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/blocs/auth/auth_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_collection.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final IServiceCollection services;

  final IAuthSession _authSession;
  final IAuthDataSource _authDataSource;
  final IMemberSession _memberSession;
  final IMemberDataSource _memberDataSource;

  AuthBloc({@required this.services}) :
      assert (services != null),
      _authSession = services.getService<IAuthSession>(),
      _authDataSource = services.getService<IAuthDataSource>(),
      _memberSession = services.getService<IMemberSession>(),
      _memberDataSource = services.getService<IMemberDataSource>();
  
  @override
  AuthState get initialState => new AuthUninitializedState();

  @override
  Stream<AuthState> mapEventToState(AuthState currentState, AuthEvent event) async* {
    
    if (event is AuthAppStartedEvent) {

      yield new AuthLoadingState();
      final hasToken = await this._authSession.hasCredentials();

      if (hasToken) {

        final authCredentials = await this._authSession.getPersistedAuthCredentials();
        final memberProfile = await this._memberSession.getPersistedMemberProfile();
        yield new AuthAuthenticated(
          authCredentials: authCredentials,
          memberProfile: memberProfile
        );
        this._refreshSession(authCredentials.refreshToken);

      } else
        yield new AuthUnauthenticatedState();

    }

    if (event is AuthLoggedInEvent) {

      yield new AuthLoadingState();
      await _authSession.persistAuthCredentials(event.authCredentials);
      MemberProfile memberProfile = await this._memberDataSource.getMemberProfile();
      yield new AuthAuthenticated(
        authCredentials: event.authCredentials,
        memberProfile: memberProfile
      );
      await this._memberSession.persistMemberProfile(memberProfile);

    }

    if (event is AuthLoggedOutEvent) {

      yield new AuthLoadingState();
      await this._authSession.deleteAuthCredentials();
      await this._memberSession.deletePersistedMemberProfile();
      yield new AuthUnauthenticatedState();

    }

  }

  void _refreshSession(String refreshToken) async {
    final authCredentials = await this._authDataSource.refreshCredentials(refreshToken);
    this._authSession.persistAuthCredentials(authCredentials);
    final memberProfile = await this._memberDataSource.getMemberProfile();
    this._memberSession.persistMemberProfile(memberProfile);
  }

}