import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequestModel {

  final String email;
  final String password;

  LoginRequestModel({
    @required this.email, @required this.password
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => _$LoginRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

}