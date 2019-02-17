import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source_impl.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/data_source/member/member_data_source_impl.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';
import 'package:pressy_client/utils/network/base_client.dart';

abstract class DataSourceFactory {

  static IAuthDataSource createAuthDataSource() => new AuthDataSourceImpl(
    client: Injector.getInjector().get<IClient>(), 
    apiEndpointProvider: Injector.getInjector().get<ApiEndpointProvider>()
  );

  static IMemberDataSource createMemberDataSource() => new MemberDataSourceImpl(
    client: Injector.getInjector().get<IClient>(), 
    apiEndpointProvider: Injector.getInjector().get<ApiEndpointProvider>()
  );

}