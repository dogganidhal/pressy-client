import 'package:json_annotation/json_annotation.dart';
import 'package:pressy_client/data/model/order/article/article.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {

  final int id;
  final int orderId;
  final Article article;
  final String color;
  final String comment;

  OrderItem({
    this.id, this.orderId, this.article, this.color, this.comment
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

}