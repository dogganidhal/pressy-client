import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/utils/errors/base_error.dart';

part 'api_error.g.dart';

@immutable
@JsonSerializable()
class ApiError extends AppError {

  @override
  @JsonKey(name: "name")
  final String title;

  @override
  final int statusCode;

  @override
  final String message;

  ApiError({this.title, this.statusCode, this.message});

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

}