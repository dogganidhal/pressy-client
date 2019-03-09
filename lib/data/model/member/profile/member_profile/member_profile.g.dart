// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberProfile _$MemberProfileFromJson(Map<String, dynamic> json) {
  return MemberProfile(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      addresses: (json['addresses'] as List)
          ?.map((e) => e == null
              ? null
              : MemberAddress.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      paymentAccounts: (json['paymentAccounts'] as List)
          ?.map((e) => e == null
              ? null
              : PaymentAccount.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$MemberProfileToJson(MemberProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'created': instance.created?.toIso8601String(),
      'addresses': instance.addresses,
      'paymentAccounts': instance.paymentAccounts
    };
