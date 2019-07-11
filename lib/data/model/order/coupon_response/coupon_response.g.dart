// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponVerifyResponseModel _$CouponVerifyResponseModelFromJson(
    Map<String, dynamic> json) {
  return CouponVerifyResponseModel(
      coupon: json['coupon'] == null
          ? null
          : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
      status: json['status'] as bool,
      category: json['category'] as String);
}

Map<String, dynamic> _$CouponVerifyResponseModelToJson(
        CouponVerifyResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'coupon': instance.coupon,
      'category': instance.category
    };
