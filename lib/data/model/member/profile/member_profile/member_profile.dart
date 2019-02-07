import 'package:json_annotation/json_annotation.dart';
import 'package:pressy_client/data/model/member/address/member_address/member_address.dart';

part 'member_profile.g.dart';

@JsonSerializable()
class MemberProfile {

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime created;
  final List<MemberAddress> addresses;

  MemberProfile({
    this.id, this.firstName, this.lastName, this.email, this.phone, this.created, this.addresses
  });

  factory MemberProfile.fromJson(Map<String, dynamic> json) => _$MemberProfileFromJson(json);
  Map<String, dynamic> toJson() => _$MemberProfileToJson(this);

}