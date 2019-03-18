import 'package:meta/meta.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source.dart';
import 'package:pressy_client/data/data_source/base/base_data_source.dart';
import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/model/auth/login_request/login_request.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/utils/network/base_client.dart';


class AuthDataSourceImpl extends DataSource implements IAuthDataSource {

  @override
  final IClient client;

  @override
  final ApiEndpointProvider apiEndpointProvider;

  @override
  final IAuthSession authSession;

  AuthDataSourceImpl({@required this.client, @required this.apiEndpointProvider, @required this.authSession});
  
  @override
  Future<AuthCredentials> login(LoginRequestModel loginRequest) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.auth.login,
      body: loginRequest?.toJson(),
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

  @override
  Future<AuthCredentials> refreshCredentials(String refreshToken) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.auth.refreshCredentials,
      body: { "refreshToken": refreshToken },
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

}