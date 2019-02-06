import 'dart:convert';
import 'package:http/http.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';

typedef TEntity JsonModelBuilder<TEntity>(Map<String, dynamic> json);

abstract class DataSource {

  final BaseClient client;
  final ApiEndpointProvider apiEndpointProvider;

  DataSource({this.client, this.apiEndpointProvider});

  Future<TEntity> doGet<TEntity>({
    String url, JsonModelBuilder<TEntity> responseConverter, Map<String, dynamic> headers
  }) async {
    
    var response = await this.client.get(
      url, headers: headers
    );
    var map = json.decode(response.body);
    var responseModel = responseConverter(map);
    return Future.value(responseModel);

  }

  Future<TEntity> doPost<TEntity>({
    String url, Map<String, dynamic> body, Map<String, dynamic> headers, 
    JsonModelBuilder<TEntity> responseConverter
  }) async {

    var response = await this.client.post(
      url, headers: headers, body: json.encode(body)
    );
    var map = json.decode(response.body);
    var responseModel = responseConverter(map);
    return Future.value(responseModel);

  }

  Future<TEntity> doPatch<TEntity>({
    String path, Map<String, dynamic> body, Map<String, dynamic> headers, 
    JsonModelBuilder<TEntity> responseConverter
  }) async {

    var response = await this.client.patch(
      path, headers: headers, body: json.encode(body)
    );
    var map = json.decode(response.body);
    var responseModel = responseConverter(map);
    return Future.value(responseModel);

  }

  Future<TEntity> doDelete<TEntity>({
    String path, Map<String, dynamic> headers, JsonModelBuilder<TEntity> responseConverter
  }) async {

    var response = await this.client.delete(path, headers: headers);
    var map = json.decode(response.body);
    var responseModel = responseConverter(map);
    return Future.value(responseModel);

  }

}