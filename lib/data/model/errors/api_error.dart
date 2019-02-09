import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'api_error.g.dart';

@immutable
@JsonSerializable()
class ApiError {

  final String name;
  final int statusCode;
  final String message;

  ApiError({this.name, this.statusCode, this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

}