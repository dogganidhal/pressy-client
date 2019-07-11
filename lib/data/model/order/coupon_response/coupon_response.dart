import 'package:json_annotation/json_annotation.dart';
import 'package:pressy_client/data/model/order/coupon/coupon.dart';

part 'coupon_response.g.dart';

@JsonSerializable()
class CouponVerifyResponseModel {
  final bool status;
  final Coupon coupon;
  final String category;
  CouponVerifyResponseModel({this.coupon, this.status, this.category});

  factory CouponVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CouponVerifyResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponVerifyResponseModelToJson(this);
}
