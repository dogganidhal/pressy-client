import 'package:flutter/material.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source_impl.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/member/member_data_source_impl.dart';
import 'package:pressy_client/data/data_source/order/order_data_Srouce_impl.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/resources/resources.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/data/session/auth/auth_session_impl.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/data/session/member/member_session_impl.dart';
import 'package:pressy_client/services/di/service_collection.dart';
import 'package:pressy_client/services/di/service_collection_impl.dart';
import 'package:pressy_client/services/providers/location/flutter_user_location_provider.dart';
import 'package:pressy_client/services/providers/location/user_location_provider.dart';
import 'package:pressy_client/utils/network/base_client.dart';
import 'package:pressy_client/utils/network/http_client.dart';
import 'package:pressy_client/widgets/app/app.dart';

void main() => runApp(new Application(services: configureServices()));

IServiceCollection configureServices() {
  
  final services = new ServiceCollectionImpl();

  services.addSingleton<IAuthSession>((_) => new AuthSessionImpl());
  services.addSingleton<IMemberSession>((_) => new MemberSessionImpl());
  services.addScoped<IClient>((_) => new HttpClient());
  services.addScoped<ApiEndpointProvider>((_) => new ApiEndpointProvider());
  services.addScoped<IUserLocationProvider>((_) => new FlutterUserLocationProvider());
  services.addScoped<IMemberDataSource>((services) => new MemberDataSourceImpl(
    apiEndpointProvider: services.getService<ApiEndpointProvider>(),
    client: services.getService<IClient>(),
    authSession: services.getService<IAuthSession>()
  ));
  services.addScoped<IAuthDataSource>((services) => new AuthDataSourceImpl(
    apiEndpointProvider: services.getService<ApiEndpointProvider>(),
    client: services.getService<IClient>(),
    authSession: services.getService<IAuthSession>()
  ));
  services.addScoped<IOrderDataSource>((services) => new OrderDataSourceImpl(
    apiEndpointProvider: services.getService<ApiEndpointProvider>(),
    client: services.getService<IClient>(),
    authSession: services.getService<IAuthSession>()
  ));

  return services;
  
}
