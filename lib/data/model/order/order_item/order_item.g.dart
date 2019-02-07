// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
      id: json['id'] as int,
      orderId: json['orderId'] as int,
      article: json['article'] == null
          ? null
          : Article.fromJson(json['article'] as Map<String, dynamic>),
      color: json['color'] as String,
      comment: json['comment'] as String);
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'article': instance.article,
      'color': instance.color,
      'comment': instance.comment
    };
