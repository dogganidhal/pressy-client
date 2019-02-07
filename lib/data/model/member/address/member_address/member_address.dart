import 'package:json_annotation/json_annotation.dart';

part 'member_address.g.dart';

@JsonSerializable()
class MemberAddress {

  final int id;
  final String streetName;
  final String streetNumber;
  final String country;
  final String zipCode;
  final String formattedAddress;
  final String name;
  final String extraLine;

  MemberAddress({
    this.id, this.streetName, this.streetNumber, this.country, this.zipCode, 
    this.formattedAddress, this.name, this.extraLine
  });

  factory MemberAddress.fromJson(Map<String, dynamic> json) => _$MemberAddressFromJson(json);
  Map<String, dynamic> toJson() => _$MemberAddressToJson(this);

}