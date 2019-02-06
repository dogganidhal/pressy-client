import 'package:http/http.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source_impl.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/data_source/member/member_data_source_impl.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';

abstract class DataSourceFactory {

  static BaseClient _client = new Client();
  static ApiEndpointProvider _apiEndpointProvider = new ApiEndpointProvider();

  static void setClient(BaseClient client) => _client = client;
  static void setApiEndpointProvider(ApiEndpointProvider provider) => 
    _apiEndpointProvider = provider;

  static IAuthDataSource createAuthDataSource() => 
    new AuthDataSourceImpl(client: _client, apiEndpointProvider: _apiEndpointProvider);

  static IMemberDataSource createMemberDataSource() => 
    new MemberDataSourceImpl(client: _client, apiEndpointProvider: _apiEndpointProvider);

}