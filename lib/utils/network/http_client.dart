import 'package:http/http.dart';
import 'package:pressy_client/utils/network/base_client.dart';

class HttpClient extends IClient {

  @override
  String authorizationHeader;

  final Client _inner = new Client();

  HttpClient({this.authorizationHeader});

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    this._logRequest(request);
    request.headers["authorization"] = this.authorizationHeader;
    return this._inner.send(request);
  }

  void _logRequest(BaseRequest request) async {
    print(
      '${request.method} ${request.url}\n'
      'Headers: ${request.headers}'
    );
  }

}