import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart' as HttpTesting show MockClient;
import 'package:pressy_client/utils/network/base_client.dart';

class FlutterMockClient extends HttpTesting.MockClient implements IClient {

  final int delayInMilliSeconds;

  FlutterMockClient({this.delayInMilliSeconds = 3000}) : super((Request request) async {

    return Future.delayed(new Duration(milliseconds: delayInMilliSeconds), () async {
      var json = await rootBundle.loadString("assets/mocks${request.url.path}/${request.method.toLowerCase()}.json");
      return new Response(json, 200);
    });

  });

}