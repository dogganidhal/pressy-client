// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
      id: json['id'] as int,
      type: _$enumDecodeNullable(_$OrderTypeEnumMap, json['type']),
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

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$OrderTypeEnumMap = <OrderType, dynamic>{
  OrderType.PRESSING: 'PRESSING',
  OrderType.WEIGHT: 'WEIGHT'
};
