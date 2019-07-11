// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['duration']);
  return Coupon(
      id: json['id'] as String,
      object: json['object'] as String,
      amountOff: json['amount_off'] as int,
      created: json['created'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              (json['created'] as int) * 1000),
      currency: json['currency'] as String,
      duration: json['duration'] == null ? null : json['duration'] as String,
      durationInMonths: json['duration_in_months'] as int,
      liveMode: json['livemode'] as bool,
      maxRedemptions: json['max_redemptions'] as int,
      metadata: json['metadata'] as Map<String, dynamic>,
      name: json['name'] as String,
      percentOff: (json['percent_off'] as num)?.toDouble(),
      redeemBy: json['redeem_by'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              (json['redeem_by'] as int) * 1000),
      timesRedeemed: json['times_redeemed'] as int,
      valid: json['valid'] as bool);
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'amount_off': instance.amountOff,
      'created': instance.created?.toIso8601String(),
      'currency': instance.currency,
      'duration': _$CouponDurationEnumMap[instance.duration],
      'duration_in_months': instance.durationInMonths,
      'livemode': instance.liveMode,
      'max_redemptions': instance.maxRedemptions,
      'metadata': instance.metadata,
      'name': instance.name,
      'percent_off': instance.percentOff,
      'redeem_by': instance.redeemBy?.toIso8601String(),
      'times_redeemed': instance.timesRedeemed,
      'valid': instance.valid
    };

const _$CouponDurationEnumMap = <CouponDuration, dynamic>{
  CouponDuration.forever: 'forever',
  CouponDuration.once: 'once',
  CouponDuration.repeating: 'repeating'
};
