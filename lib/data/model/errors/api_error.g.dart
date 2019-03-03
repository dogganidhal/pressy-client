// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return ApiError(
      title: json['name'] as String,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String);
}

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'name': instance.title,
      'statusCode': instance.statusCode,
      'message': instance.message
    };
