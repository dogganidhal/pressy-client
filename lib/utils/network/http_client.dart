import 'package:http/http.dart';

class IkriHttpClient extends BaseClient {

  final String userAgent;
  final String authHeader;
  final Client _inner = new Client();

  IkriHttpClient({this.authHeader, this.userAgent});

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    this._logRequest(request);
    request.headers["user-agent"] = this.userAgent;
    request.headers["authorization"] = this.authHeader;
    return this._inner.send(request);
  }

  void _logRequest(BaseRequest request) async {
    print(request.toString());
  }

}