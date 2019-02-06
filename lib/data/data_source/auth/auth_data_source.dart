import 'package:pressy_client/data/model/model.dart';

abstract class IAuthDataSource {

  Future<AuthCredentials> login(LoginRequestModel loginRequest);
  Future<AuthCredentials> refreshCredentials(String refreshToken);
  Future<AuthCredentials> signUp(SignUpRequestModel signUpRequest);

}