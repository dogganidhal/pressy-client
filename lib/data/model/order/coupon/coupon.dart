import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'coupon.g.dart';

enum CouponType { TWENTY_EURO_COUPON, FIVE_EURO_COUPON, TEN_EURO_COUPON }
enum CouponStatus { REDEEMED, NOT_REDEEMED, INACTIVE }
enum CouponDuration { forever, once, repeating }
//enum CouponCategory {
//  percent,
//  amount,
//}

@JsonSerializable()
class Coupon {
  final String id;
  final String object;
  @JsonKey(name: "amount_off")
  final int amountOff;
  final DateTime created;
  final String currency;
  @JsonKey(
    required: true,
  )
  final String duration;
  @JsonKey(name: "duration_in_months")
  final int durationInMonths;
  @JsonKey(name: "livemode")
  final bool liveMode;
  @JsonKey(name: "max_redemptions")
  final int maxRedemptions;
  @JsonKey(name: "metadata")
  final Map metadata;
  final String name;
  @JsonKey(name: "percent_off")
  final double percentOff;
  @JsonKey(name: "redeem_by")
  final DateTime redeemBy;
  @JsonKey(name: "times_redeemed")
  final int timesRedeemed;
  final bool valid;

  Coupon(
      {this.id,
      this.object,
      this.amountOff,
      this.created,
      this.currency,
      @required this.duration,
      this.durationInMonths,
      this.liveMode,
      this.maxRedemptions,
      this.metadata,
      this.name,
      this.percentOff,
      this.redeemBy,
      this.timesRedeemed,
      this.valid});

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
