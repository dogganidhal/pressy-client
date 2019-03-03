// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_credit_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCreditCardRequestModel _$CreateCreditCardRequestModelFromJson(
    Map<String, dynamic> json) {
  return CreateCreditCardRequestModel(
      cardNumber: json['card_number'] as String,
      cardExpiryMonth: json['card_expiry_month'] as String,
      cardHolderName: json['card_holder'] as String,
      cvc: json['cvc'] as String,
      cardExpiryYear: json['card_expiry_year'] as String);
}

Map<String, dynamic> _$CreateCreditCardRequestModelToJson(
        CreateCreditCardRequestModel instance) =>
    <String, dynamic>{
      'card_number': instance.cardNumber,
      'cvc': instance.cvc,
      'card_holder': instance.cardHolderName,
      'card_expiry_month': instance.cardExpiryMonth,
      'card_expiry_year': instance.cardExpiryYear
    };
