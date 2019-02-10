import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart';
import 'package:pressy_client/data/resources/resources.dart';
import 'package:pressy_client/utils/network/flutter_mock_client.dart';
import 'package:pressy_client/widgets/app/app.dart';

var injector = Injector.getInjector();

void main() {
  
  injector.map<BaseClient>((_) => new FlutterMockClient());
  injector.map<ApiEndpointProvider>((_) => new ApiEndpointProvider());

  runApp(new Application());

}
