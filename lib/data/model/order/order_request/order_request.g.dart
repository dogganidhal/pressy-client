// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequestModel _$OrderRequestModelFromJson(Map<String, dynamic> json) {
  return OrderRequestModel(
      pickupSlotId: json['pickupSlotId'] as int,
      deliverySlotId: json['deliverySlotId'] as int,
      addressId: json['addressId'] as int,
      type: json['type'] as String,
      paymentAccountId: json['paymentAccountId'] as String);
}

Map<String, dynamic> _$OrderRequestModelToJson(OrderRequestModel instance) =>
    <String, dynamic>{
      'pickupSlotId': instance.pickupSlotId,
      'deliverySlotId': instance.deliverySlotId,
      'addressId': instance.addressId,
      'paymentAccountId': instance.paymentAccountId,
      'type': instance.type
    };
