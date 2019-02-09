import 'dart:convert';
import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionImpl implements IAuthSession {

  static const String _AUTH_CREDENTIALS_KEY = "@pressy/auth-credentials";

  @override
  Future<void> deleteAuthCredentials() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_AUTH_CREDENTIALS_KEY);
  }

  @override
  Future<AuthCredentials> getPersistedAuthCredentials() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var authCredentialsString = sharedPreferences.getString(_AUTH_CREDENTIALS_KEY);
    if (authCredentialsString != null) {
      var map = json.decode(authCredentialsString);
      return AuthCredentials.fromJson(map);
    }
    return null;
  }

  @override
  Future<bool> hasCredentials() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_AUTH_CREDENTIALS_KEY) != null;
  }

  @override
  Future<void> persistAuthCredentials(AuthCredentials credentials) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var authCredentialsString = json.encode(credentials.toJson());
    await sharedPreferences.setString(_AUTH_CREDENTIALS_KEY, authCredentialsString);
  }

}