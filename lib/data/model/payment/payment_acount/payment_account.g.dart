// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAccount _$PaymentAccountFromJson(Map<String, dynamic> json) {
  return PaymentAccount(
      cardAlias: json['cardAlias'] as String,
      cvc: json['cvc'] as String,
      expiryMonth: json['expiryMonth'] as int,
      expiryYear: json['expiryYear'] as int,
      holderName: json['holderName'] as String);
}

Map<String, dynamic> _$PaymentAccountToJson(PaymentAccount instance) =>
    <String, dynamic>{
      'cardAlias': instance.cardAlias,
      'cvc': instance.cvc,
      'holderName': instance.holderName,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear
    };
