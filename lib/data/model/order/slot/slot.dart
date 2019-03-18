import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

enum SlotType {
  STANDARD, VIP
}

@JsonSerializable()
class Slot {

  final int id;
  final String type;
  final DateTime startDate;

  Slot({this.id, this.type, this.startDate});

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
  Map<String, dynamic> toJson() => _$SlotToJson(this);

  SlotType get slotType => this.type == "vip" ? SlotType.VIP : SlotType.STANDARD;

}