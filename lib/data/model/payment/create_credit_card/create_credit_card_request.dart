import 'package:json_annotation/json_annotation.dart';


part 'create_credit_card_request.g.dart';


@JsonSerializable()
class CreateCreditCardRequestModel {

  @JsonKey(name: "card_number")
  final String cardNumber;

  @JsonKey(name: "cvc")
  final String cvc;

  @JsonKey(name: "card_holder")
  final String cardHolderName;

  @JsonKey(name: "card_expiry_month")
  final String cardExpiryMonth;

  @JsonKey(name: "card_expiry_year")
  final String cardExpiryYear;

  CreateCreditCardRequestModel({
    this.cardNumber, this.cardExpiryMonth, this.cardHolderName,
    this.cvc, this.cardExpiryYear
  });

  factory CreateCreditCardRequestModel.fromJson(Map<String, dynamic> json) => _$CreateCreditCardRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCreditCardRequestModelToJson(this);

}