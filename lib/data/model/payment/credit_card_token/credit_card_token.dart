import 'package:json_annotation/json_annotation.dart';


part 'credit_card_token.g.dart';


@JsonSerializable()
class CreditCardTokenModel {

  @JsonKey(name: "token")
  final String token;

  @JsonKey(name: "request_id")
  final String requestId;

  @JsonKey(name: "card_hash")
  final String cardHash;

  @JsonKey(name: "brand")
  final String brand;

  @JsonKey(name: "card_holder")
  final String cardHolderName;

  @JsonKey(name: "card_expiry_month")
  final String cardExpiryMonth;

  @JsonKey(name: "card_expiry_year")
  final String cardExpiryYear;

  @JsonKey(name: "country")
  final String country;

  @JsonKey(name: "card_type")
  final String cardType;

  CreditCardTokenModel({
    this.token, this.requestId, this.cardHash, this.brand, this.cardHolderName,
    this.cardExpiryMonth, this.cardExpiryYear, this.country, this.cardType
  });

  factory CreditCardTokenModel.fromJson(Map<String, dynamic> json) => _$CreditCardTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardTokenModelToJson(this);

}