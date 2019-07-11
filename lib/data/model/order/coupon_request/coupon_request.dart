import 'package:json_annotation/json_annotation.dart';

part 'coupon_request.g.dart';

@JsonSerializable()
class CouponVerifyRequestModel {
  final String id;

  CouponVerifyRequestModel({this.id});

  factory CouponVerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CouponVerifyRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponVerifyRequestModelToJson(this);
}
