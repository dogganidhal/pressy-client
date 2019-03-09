import 'package:json_annotation/json_annotation.dart';

part 'payment_account.g.dart';

@JsonSerializable()
class PaymentAccount {

  final String cardAlias;
  final String cvc;
  final String holderName;
  final int expiryMonth;
  final int expiryYear;

  PaymentAccount({
    this.cardAlias, this.cvc, this.expiryMonth, this.expiryYear, this.holderName
  });

  factory PaymentAccount.fromJson(Map<String, dynamic> json) => _$PaymentAccountFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentAccountToJson(this);

}