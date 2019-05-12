import 'package:json_annotation/json_annotation.dart';


part 'credit_card_token.g.dart';


@JsonSerializable()
class CreditCardTokenModel {

  final String cardToken;
  final String cardAlias;
  final String holderName;
  final String expiryMonth;
  final String expiryYear;
  final String cvc;

  CreditCardTokenModel({
    this.cardToken, this.holderName, this.cardAlias, 
    this.expiryMonth, this.expiryYear, this.cvc
  });

  factory CreditCardTokenModel.fromJson(Map<String, dynamic> json) => _$CreditCardTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardTokenModelToJson(this);

}