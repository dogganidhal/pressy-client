import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart';
import 'package:pressy_client/data/resources/resources.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/data/session/auth/auth_session_impl.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/data/session/member/member_session_impl.dart';
import 'package:pressy_client/utils/network/flutter_mock_client.dart';
import 'package:pressy_client/widgets/app/app.dart';

var injector = Injector.getInjector();

void main() {
  
  injector.map<BaseClient>((_) => new FlutterMockClient(), isSingleton: true);
  injector.map<ApiEndpointProvider>((_) => new ApiEndpointProvider(), isSingleton: true);
  injector.map<IMemberSession>((_) => new MemberSessionImpl());
  injector.map<IAuthSession>((_) => new AuthSessionImpl());

  runApp(new Application());

}
