// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequestModel _$OrderRequestModelFromJson(Map<String, dynamic> json) {
  return OrderRequestModel(
      pickupSlotId: json['pickupSlotId'] as int,
      appliedCouponCode: json['used_coupon_id'] as String,
      isCouponApplied: json['isCouponApplied'] as bool,
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
      'type': instance.type,
      'isCouponApplied': instance.isCouponApplied,
      'used_coupon_id': instance.appliedCouponCode
    };
