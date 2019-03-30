import 'dart:convert';
import 'package:http/http.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/utils/network/base_client.dart';

typedef TEntity JsonModelBuilder<TEntity>(dynamic json);

abstract class DataSource {

  final IClient client;
  final ApiEndpointProvider apiEndpointProvider;
  final IAuthSession authSession;

  DataSource({this.client, this.apiEndpointProvider, this.authSession});

  Future<Entity> handleRequest<Entity>({
    ApiEndpoint endpoint, Map<String, dynamic> body, JsonModelBuilder<Entity> responseConverter
  }) async {

    Response response;
    String bodyJson = json.encode(body);
    Map<String, String> headers = this._prepareHeaders(endpoint);

    switch(endpoint.method) {
      case "POST":
        response = await this.client.post(
          this.apiEndpointProvider.baseUrl + endpoint.path,
          body: bodyJson, headers: headers
        );
        break;
      case "GET":
        response = await this.client.get(
          this.apiEndpointProvider.baseUrl + endpoint.path,
          headers: headers
        );
        break;
      case "PATCH":
        response = await this.client.patch(
          this.apiEndpointProvider.baseUrl + endpoint.path,
          body: bodyJson, headers: headers
        );
        break;
      default: // DELETE
        response = await this.client.delete(
          this.apiEndpointProvider.baseUrl + endpoint.path,
          headers: headers
        );
        break;
    }

    if (responseConverter != null) {
      final map = response.contentLength > 0 ? json.decode(response.body) : null;
      if (response.statusCode >= 400) {
        throw new ApiError.fromJson(map);
      }
      return Future.value(responseConverter(map));
    }

    return Future.value();

  }

  Future<TEntity> doGet<TEntity>({
    String url, JsonModelBuilder<TEntity> responseConverter, Map<String, dynamic> headers
  }) async {

    var response = await this.client.get(url, headers: this._injectHeaders(headers));
    var map = json.decode(response.body);
    if (response.statusCode >= 400) {
      throw new ApiError.fromJson(map);
    }
    return Future.value(responseConverter != null ? responseConverter(map) : null);

  }

  Future<TEntity> doPost<TEntity>({
    String url, Map<String, dynamic> body, Map<String, dynamic> headers, 
    JsonModelBuilder<TEntity> responseConverter
  }) async {

    var response = await this.client.post(url, headers: this._injectHeaders(headers), body: json.encode(body));
    var map = json.decode(response.body);
    if (response.statusCode >= 400) {
      throw new ApiError.fromJson(map);
    }
    return Future.value(responseConverter != null ? responseConverter(map) : null);

  }

  Future<TEntity> doPatch<TEntity>({
    String url, Map<String, dynamic> body, Map<String, dynamic> headers, 
    JsonModelBuilder<TEntity> responseConverter
  }) async {

    var response = await this.client.patch(url, headers: this._injectHeaders(headers), body: json.encode(body));
    var map = json.decode(response.body);
    if (response.statusCode >= 400) {
      throw new ApiError.fromJson(map);
    }
    return Future.value(responseConverter != null ? responseConverter(map) : null);

  }

  Future<TEntity> doDelete<TEntity>({
    String url, Map<String, dynamic> headers, JsonModelBuilder<TEntity> responseConverter
  }) async {

    var response = await this.client.delete(url, headers: this._injectHeaders(headers));
    var map = json.decode(response.body);
    if (response.statusCode >= 400) {
      throw new ApiError.fromJson(map);
    }
    return Future.value(responseConverter != null ? responseConverter(map) : null);

  }

  Map<String, String> _prepareHeaders(ApiEndpoint endpoint) {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    if (endpoint.needsAuthorization) {
      headers["Authorization"] = "Bearer ${this.authSession.credentials?.accessToken}";
    }
    return headers;
  }

  Map<String, dynamic> _injectHeaders(Map<String, dynamic> headers) {
    var injectableHeaders = {
      "Authorization": "${this.authSession.credentials?.tokenType} ${this.authSession.credentials?.accessToken}",
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    if (headers == null) {
      return injectableHeaders;
    }
    injectableHeaders.addEntries(headers.entries);
    return injectableHeaders;
  }

}