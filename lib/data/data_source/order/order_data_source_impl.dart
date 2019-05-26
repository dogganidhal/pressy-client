import 'package:pressy_client/data/data_source/base/base_data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/order/article/article.dart';
import 'package:pressy_client/data/model/order/order/order.dart';
import 'package:pressy_client/data/model/order/order_request/order_request.dart';
import 'package:pressy_client/data/model/order/slot/slot.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/utils/network/base_client.dart';


class OrderDataSourceImpl extends DataSource implements IOrderDataSource {

  @override
  final IClient client;

  @override
  final ApiEndpointProvider apiEndpointProvider;

  @override
  final IAuthSession authSession;

  OrderDataSourceImpl({this.client, this.apiEndpointProvider, this.authSession});

  @override
  Future<List<Article>> getArticles() {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.orders.getArticles,
      responseConverter: (json) => json
        .map((article) => Article.fromJson(article))
        .toList()
        .cast<Article>()
    );
  }

  @override
  Future<List<Slot>> getPickupSlots() {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.orders.getPickupSlots,
      responseConverter: (json) => json
        .map((slot) => Slot.fromJson(slot))
        .toList()
        .cast<Slot>()
    );
  }

  @override
  Future<List<Slot>> getDeliverySlots(Slot pickupSlot) {
    return this.handleRequest(
        endpoint: this.apiEndpointProvider.orders.getDeliverySlots(pickupSlot.id),
        responseConverter: (json) => json
          .map((slot) => Slot.fromJson(slot))
          .toList()
          .cast<Slot>()
    );
  }

  @override
  Future<List<Order>> getMemberOrders() {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.orders.getOrders,
      responseConverter: (json) => json
        .map((order) => Order.fromJson(order))
        .toList()
        .cast<Order>()
    );
  }

  @override
  Future submitOrder(OrderRequestModel request) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.orders.submitOrder,
      body: request?.toJson()
    );
  }

  @override
  Future<Article> getWeightedArticle() {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.orders.getWeightedArticle,
      responseConverter: (json) => Article.fromJson(json)
    );
  }

}