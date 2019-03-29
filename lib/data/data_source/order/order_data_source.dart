import 'package:pressy_client/data/model/model.dart';

abstract class IOrderDataSource {

  Future<List<Slot>> getPickupSlots();
  Future<List<Slot>> getDeliverySlots(Slot pickupSlot);
  Future<List<Article>> getArticles();
  Future<List<Order>> getMemberOrders();
  Future submitOrder(OrderRequestModel request);
  Future<Article> getWeightedArticle();

}