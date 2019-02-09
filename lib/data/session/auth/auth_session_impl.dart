import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';

class AuthSessionImpl implements IAuthSession {
  
  @override
  Future<void> deleteAuthCredentials() {
    // TODO: implement deleteAuthCredentials
    return null;
  }

  @override
  Future<AuthCredentials> getPersistedAuthCredentials() {
    // TODO: implement getPersistedAuthCredentials
    return null;
  }

  @override
  Future<bool> hasCredentials() {
    // TODO: implement hasCredentials
    return null;
  }

  @override
  Future<void> persistAuthCredentials(AuthCredentials credentials) {
    // TODO: implement persistAuthCredentials
    return null;
  }

}