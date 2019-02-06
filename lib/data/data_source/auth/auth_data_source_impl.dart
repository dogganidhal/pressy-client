import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source.dart';
import 'package:pressy_client/data/data_source/base/base_data_source.dart';
import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/model/auth/login_request/login_request.dart';
import 'package:pressy_client/data/model/auth/sign_up_request/sign_up_request.dart';


class AuthDataSourceImpl extends DataSource implements IAuthDataSource {

  @override
  final BaseClient client;

  AuthDataSourceImpl({@required this.client});
  
  @override
  Future<AuthCredentials> login(LoginRequestModel loginRequest) {
    return this.doPost(
      url: "https://pressy-mobile-api-dev.herokuapp.com/v1/auth/login", 
      body: loginRequest.toJson(), 
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

  @override
  Future<AuthCredentials> refreshCredentials(String refreshToken) {
    return this.doPost(
      url: "https://pressy-mobile-api-dev.herokuapp.com/v1/auth/refresh",
      body: { "refreshToken": refreshToken },
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

  @override
  Future<AuthCredentials> signUp(SignUpRequestModel signUpRequest) {
    return this.doPost(
      url: "https://pressy-mobile-api-dev.herokuapp.com/v1/auth/refresh",
      body: signUpRequest.toJson(),
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

}