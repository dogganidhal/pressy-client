import 'package:flutter/material.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source_impl.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/member/member_data_source_impl.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source_impl.dart';
import 'package:pressy_client/data/data_source/payment/payment_data_source_impl.dart';
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
import 'data/data_source/payment/payment_data_source.dart';

void main() => runApp(Application(services: configureServices()));

IServiceCollection configureServices() {
  
  final services = ServiceCollectionImpl();

  services.addSingleton<IAuthSession>((_) => AuthSessionImpl());
  services.addSingleton<IMemberSession>((_) => MemberSessionImpl());
  services.addScoped<IClient>((_) => HttpClient());
  services.addScoped<ApiEndpointProvider>((_) => ApiEndpointProvider());
  services.addScoped<IUserLocationProvider>((_) => FlutterUserLocationProvider());
  services.addScoped<IPaymentDataSource>((services) => StripePaymentDataSourceImpl());
  services.addScoped<IMemberDataSource>((services) => MemberDataSourceImpl(
    apiEndpointProvider: services.getService<ApiEndpointProvider>(),
    client: services.getService<IClient>(),
    authSession: services.getService<IAuthSession>()
  ));
  services.addScoped<IAuthDataSource>((services) => AuthDataSourceImpl(
    apiEndpointProvider: services.getService<ApiEndpointProvider>(),
    client: services.getService<IClient>(),
    authSession: services.getService<IAuthSession>()
  ));
  services.addScoped<IOrderDataSource>((services) => OrderDataSourceImpl(
    apiEndpointProvider: services.getService<ApiEndpointProvider>(),
    client: services.getService<IClient>(),
    authSession: services.getService<IAuthSession>()
  ));

  return services;
  
}
