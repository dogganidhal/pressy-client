import 'package:http/http.dart';
import 'package:http/testing.dart' as HttpTesting show MockClient;

typedef Future<String> FileLoader(String path);

class MockClient extends HttpTesting.MockClient {

  final FileLoader mockFileLoader;
  final int delayInMilliSeconds;

  MockClient(this.mockFileLoader, {this.delayInMilliSeconds = 3000}) : super((Request request) async {

    return Future.delayed(new Duration(milliseconds: delayInMilliSeconds), () async {
      var json = await mockFileLoader("${request.url.path}/${request.method.toLowerCase()}.json");
      return new Response(json, 200);
    });

  });

}