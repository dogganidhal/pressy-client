import 'package:json_annotation/json_annotation.dart';

part 'auth_credentials.g.dart';

@JsonSerializable()
class AuthCredentials {

  final String accessToken;
  final String refreshToken;
  final double expiresIn;
  final String tokenType;

  AuthCredentials({
    this.accessToken, this.refreshToken, this.expiresIn, this.tokenType
  });

  factory AuthCredentials.fromJson(Map<String, dynamic> json) => _$AuthCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthCredentialsToJson(this);

}