import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source.dart';
import 'package:pressy_client/data/data_source/base/base_data_source.dart';
import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/model/auth/login_request/login_request.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';


class AuthDataSourceImpl extends DataSource implements IAuthDataSource {

  @override
  final BaseClient client;

  @override
  final ApiEndpointProvider apiEndpointProvider;

  AuthDataSourceImpl({@required this.client, @required this.apiEndpointProvider});
  
  @override
  Future<AuthCredentials> login(LoginRequestModel loginRequest) {
    return this.doPost(
      url: "${this.apiEndpointProvider.baseUrl}${this.apiEndpointProvider.authEndpoints.login}", 
      body: loginRequest?.toJson(), 
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

  @override
  Future<AuthCredentials> refreshCredentials(String refreshToken) {
    return this.doPost(
      url: "${this.apiEndpointProvider.baseUrl}${this.apiEndpointProvider.authEndpoints.refreshCredentials}",
      body: { "refreshToken": refreshToken },
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

}