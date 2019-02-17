import 'package:pressy_client/data/model/model.dart';


abstract class IAuthSession {

  AuthCredentials get credentials;

  Future<void> persistAuthCredentials(AuthCredentials credentials);

  Future<AuthCredentials> getPersistedAuthCredentials();
  Future<bool> hasCredentials();

  Future<void> deleteAuthCredentials();

}