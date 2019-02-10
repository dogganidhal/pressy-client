import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source_impl.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/data_source/member/member_data_source_impl.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';

abstract class DataSourceFactory {

  static IAuthDataSource createAuthDataSource() => new AuthDataSourceImpl(
    client: Injector.getInjector().get<BaseClient>(), 
    apiEndpointProvider: Injector.getInjector().get<ApiEndpointProvider>()
  );

  static IMemberDataSource createMemberDataSource() => new MemberDataSourceImpl(
    client: Injector.getInjector().get<BaseClient>(), 
    apiEndpointProvider: Injector.getInjector().get<ApiEndpointProvider>()
  );

}