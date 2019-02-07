// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestModel _$SignUpRequestModelFromJson(Map<String, dynamic> json) {
  return SignUpRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      lastName: json['lastName'] as String);
}

Map<String, dynamic> _$SignUpRequestModelToJson(SignUpRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName
    };
