import 'dart:convert';
import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionImpl implements IAuthSession {

  @override
  AuthCredentials get credentials => this._credentials;

  AuthCredentials _credentials;

  static const String _AUTH_CREDENTIALS_KEY = "@pressy/auth-credentials";

  @override
  Future<void> deleteAuthCredentials() async {
    this._credentials = null;
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_AUTH_CREDENTIALS_KEY);
  }

  @override
  Future<AuthCredentials> getPersistedAuthCredentials() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var authCredentialsString = sharedPreferences.getString(_AUTH_CREDENTIALS_KEY);
    AuthCredentials credentials;
    if (authCredentialsString != null) {
      var map = json.decode(authCredentialsString);
      credentials = AuthCredentials.fromJson(map);
    }
    this._credentials = credentials;
    return credentials;
  }

  @override
  Future<bool> hasCredentials() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_AUTH_CREDENTIALS_KEY) != null;
  }

  @override
  Future<void> persistAuthCredentials(AuthCredentials credentials) async {
    this._credentials = credentials;
    var sharedPreferences = await SharedPreferences.getInstance();
    var authCredentialsString = json.encode(credentials.toJson());
    await sharedPreferences.setString(_AUTH_CREDENTIALS_KEY, authCredentialsString);
  }

}