// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAccount _$PaymentAccountFromJson(Map<String, dynamic> json) {
  return PaymentAccount(
      cardAlias: json['cardAlias'] as String,
      cvc: json['cvc'] as String,
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      holderName: json['holderName'] as String,
      id: json['id'] as String);
}

Map<String, dynamic> _$PaymentAccountToJson(PaymentAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardAlias': instance.cardAlias,
      'cvc': instance.cvc,
      'holderName': instance.holderName,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear
    };
