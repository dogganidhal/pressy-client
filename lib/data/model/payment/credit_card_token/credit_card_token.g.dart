// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardTokenModel _$CreditCardTokenModelFromJson(Map<String, dynamic> json) {
  return CreditCardTokenModel(
      token: json['token'] as String,
      requestId: json['request_id'] as String,
      cardHash: json['card_hash'] as String,
      brand: json['brand'] as String,
      cardHolderName: json['card_holder'] as String,
      cardExpiryMonth: json['card_expiry_month'] as String,
      cardExpiryYear: json['card_expiry_year'] as String,
      country: json['country'] as String,
      cardType: json['card_type'] as String);
}

Map<String, dynamic> _$CreditCardTokenModelToJson(
        CreditCardTokenModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'request_id': instance.requestId,
      'card_hash': instance.cardHash,
      'brand': instance.brand,
      'card_holder': instance.cardHolderName,
      'card_expiry_month': instance.cardExpiryMonth,
      'card_expiry_year': instance.cardExpiryYear,
      'country': instance.country,
      'card_type': instance.cardType
    };
