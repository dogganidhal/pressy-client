// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
      id: json['id'] as int,
      type:
          json['type'] == null ? null : Order._orderTypeFromJson(json['type']),
      pickupSlot: json['pickupSlot'] == null
          ? null
          : Slot.fromJson(json['pickupSlot'] as Map<String, dynamic>),
      deliverySlot: json['deliverySlot'] == null
          ? null
          : Slot.fromJson(json['deliverySlot'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : MemberAddress.fromJson(json['address'] as Map<String, dynamic>),
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : OrderItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$OrderTypeEnumMap[instance.type],
      'pickupSlot': instance.pickupSlot,
      'deliverySlot': instance.deliverySlot,
      'items': instance.items,
      'address': instance.address
    };

const _$OrderTypeEnumMap = <OrderType, dynamic>{
  OrderType.PRESSING: 'PRESSING',
  OrderType.WEIGHT: 'WEIGHT'
};
