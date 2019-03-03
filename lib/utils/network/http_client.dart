import 'dart:convert';

import 'package:http/http.dart';
import 'package:pressy_client/utils/network/base_client.dart';

class HttpClient extends IClient {

  final Client _inner = new Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) => this._inner.send(request);

  @override
  Future<Response> get(url, {Map<String, String> headers}) async {
    this._logRequest(url: url, headers: headers, method: "GET");
    final response = await this._inner.get(url, headers: headers);
    this._logResponse(response);
    return response;
  }

  @override
  Future<Response> post(url, {Map<String, String> headers, body, Encoding encoding}) async {
    this._logRequest(url: url, headers: headers, method: "POST", body: body);
    final response = await this._inner.post(url, headers: headers, body: body, encoding: encoding);
    this._logResponse(response);
    return response;
  }

  @override
  Future<Response> patch(url, {Map<String, String> headers, body, Encoding encoding}) async {
    this._logRequest(url: url, headers: headers, method: "PATCH", body: body);
    final response = await this._inner.patch(url, headers: headers, body: body, encoding: encoding);
    this._logResponse(response);
    return response;
  }
  
  @override
  Future<Response> delete(url, {Map<String, String> headers}) async {
    this._logRequest(url: url, headers: headers, method: "DELETE");
    final response = await this._inner.delete(url, headers: headers);
    this._logResponse(response);
    return response;
  }

  void _logResponse(Response response) {
    print(
      'Http Response : {\n'
      '  Status code : ${response.statusCode},\n'
      '  Body : ${response.body}\n'
    );
  }

  void _logRequest({String method, String url, Map<String, String> headers, dynamic body}) async {
    final stringBuffer = new StringBuffer();
    stringBuffer.write(
      'Http Request : $method $url\n'
      'Headers: $headers\n'
    );
    if (body != null)
      stringBuffer.write('Body: $body');
    print(stringBuffer.toString());
  }

}