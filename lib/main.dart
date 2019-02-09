import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/utils/network/mock_client.dart';
import 'package:pressy_client/widgets/app/app.dart';

void main() {

  DataSourceFactory.setClient(new MockClient((path) => rootBundle.loadString(path)));
  runApp(new Application());

}
