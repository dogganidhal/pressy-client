import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequestModel {

  final int pickupSlotId;
  final int deliverySlotId;
  final int addressId;
  final String paymentAccountId;
  final String type;

  OrderRequestModel({this.pickupSlotId, this.deliverySlotId, this.addressId, this.type, this.paymentAccountId});

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) => _$OrderRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderRequestModelToJson(this);

}