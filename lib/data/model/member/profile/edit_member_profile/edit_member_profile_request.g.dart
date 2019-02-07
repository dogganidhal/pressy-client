// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_member_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditMemberProfileRequestModel _$EditMemberProfileRequestModelFromJson(
    Map<String, dynamic> json) {
  return EditMemberProfileRequestModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String);
}

Map<String, dynamic> _$EditMemberProfileRequestModelToJson(
        EditMemberProfileRequestModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone
    };
