import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/data_source/base/base_data_source.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/model/auth/sign_up_request/sign_up_request.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';


class MemberDataSourceImpl extends DataSource implements IMemberDataSource {

  @override
  final BaseClient client;

  @override
  final ApiEndpointProvider apiEndpointProvider;

  MemberDataSourceImpl({@required this.apiEndpointProvider, @required this.client});
  
  @override
  Future<AuthCredentials> signUp(SignUpRequestModel signUpRequest) {
    return this.doPost(
      url: "${this.apiEndpointProvider.baseUrl}${this.apiEndpointProvider.memberEndpoints.signUp}",
      body: signUpRequest.toJson(),
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

}