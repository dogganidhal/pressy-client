import 'package:pressy_client/data/model/model.dart';

abstract class IOrderDataSource {

  Future<List<Slot>> getAvailableSlots();
  Future<List<Article>> getArticles();
  Future<List<Order>> getMemberOrders();
  Future submitOrder(OrderRequestModel request);

}