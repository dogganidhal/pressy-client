import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequestModel {

  final int pickupSlotId;
  final int deliverySlotId;
  final int addressId;
  final int type;

  OrderRequestModel({this.pickupSlotId, this.deliverySlotId, this.addressId, this.type});

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) => _$OrderRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderRequestModelToJson(this);

}