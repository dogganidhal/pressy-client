import 'package:json_annotation/json_annotation.dart';
import 'package:pressy_client/data/model/member/address/member_address/member_address.dart';
import 'package:pressy_client/data/model/payment/payment_acount/payment_account.dart';

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
  final List<PaymentAccount> paymentAccounts;

  MemberProfile({
    this.id, this.firstName, this.lastName, this.email, this.phone, this.created,
    this.addresses, this.paymentAccounts
  });

  factory MemberProfile.fromJson(Map<String, dynamic> json) => _$MemberProfileFromJson(json);
  Map<String, dynamic> toJson() => _$MemberProfileToJson(this);

}