// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardTokenModel _$CreditCardTokenModelFromJson(Map<String, dynamic> json) {
  return CreditCardTokenModel(
      cardToken: json['cardToken'] as String,
      holderName: json['holderName'] as String,
      cardAlias: json['cardAlias'] as String,
      expiryMonth: json['expiryMonth'] as String,
      expiryYear: json['expiryYear'] as String,
      cvc: json['cvc'] as String);
}

Map<String, dynamic> _$CreditCardTokenModelToJson(
        CreditCardTokenModel instance) =>
    <String, dynamic>{
      'cardToken': instance.cardToken,
      'cardAlias': instance.cardAlias,
      'holderName': instance.holderName,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'cvc': instance.cvc
    };
