import 'dart:io';
import 'package:http/http.dart';
import 'package:http/testing.dart' as HttpTesting show MockClient;
import 'package:pressy_client/utils/network/base_client.dart';

class TestMockClient extends HttpTesting.MockClient implements IClient {

  final int delayInMilliSeconds;

  TestMockClient({this.delayInMilliSeconds = 3000}) : super((Request request) async {

    return Future.delayed(Duration(milliseconds: delayInMilliSeconds), () async {
      var mockFilesUri = Platform.script.resolve("../assets/mocks${request.url.path}/${request.method.toLowerCase()}.json");
      var mockFile = File.fromUri(mockFilesUri);
      var json = await mockFile.readAsString();
      return Response(json, 200);
    });

  });

}