import 'package:json_annotation/json_annotation.dart';

part 'payment_account.g.dart';

@JsonSerializable()
class PaymentAccount {

  final String id;
  final String cardAlias;
  final String cvc;
  final String holderName;
  final dynamic expiryMonth;
  final dynamic expiryYear;

  PaymentAccount({
    this.cardAlias, this.cvc, this.expiryMonth, this.expiryYear, this.holderName, this.id
  });

  factory PaymentAccount.fromJson(Map<String, dynamic> json) => _$PaymentAccountFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentAccountToJson(this);

}