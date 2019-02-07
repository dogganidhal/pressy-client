import 'package:json_annotation/json_annotation.dart';
import 'package:pressy_client/data/model/member/address/member_address/member_address.dart';
import 'package:pressy_client/data/model/order/order_item/order_item.dart';
import 'package:pressy_client/data/model/order/slot/slot.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {

  final int id;
  final int type;
  final Slot pickupSlot;
  final Slot deliverySlot;
  final List<OrderItem> items;
  final MemberAddress address;

  Order({
    this.id, this.type, this.pickupSlot, this.deliverySlot, this.address, this.items
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

}